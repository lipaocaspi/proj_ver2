import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/data/repository/models/messages_model.dart';
import 'package:proj_ver1/UserRidesPage/components/selected_message_p.dart';

class RidePageP extends StatefulWidget {
  RidePageP({Key? key, required this.id, required this.ride, required this.users}) : super(key: key);
  final int id;
  final Ride ride;
  final Users users;
  final List <Users> _usersC = [];
  final List<Message> _message = [];
  final List<Message> _messageCount = [];

  @override
  State<RidePageP> createState() => _RidePageStateP();
}

class _RidePageStateP extends State<RidePageP> {
  bool isTapped = true;
  GoogleMapController? controller;
  List<Marker> _markers = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  showChat() async {
    final response = await http.get(Uri.parse("http://192.168.0.109:3000/users"));

    if (response.statusCode == 200) {
      List<dynamic> myUsers = json.decode(utf8.decode(response.bodyBytes));
      List<Users> user = myUsers.map((e) => Users.fromJson(e)).toList();
      setState(() {
        widget._usersC.addAll(user);
      });
      for(int i = 0; i <= (widget._usersC.length)-1; i++) {
        if(widget._usersC[i].id == widget.ride.userId) {
          widget._message.clear();
          final response = await http.get(Uri.parse("http://192.168.0.109:3000/messages"));
          if (response.statusCode == 200) {
            List<dynamic> myMessages = json.decode(utf8.decode(response.bodyBytes));
            List<Message> message = myMessages.map((e) => Message.fromJson(e)).toList();
            setState(() {
              widget._messageCount.addAll(message);
              widget._message.addAll(message.where((element) => element.userIdOne == widget._usersC[i].id || element.userIdTwo == widget._usersC[i].id));
            });
            Navigator.of(context).push(
              PageTransition(
                child: MessagePageP(idU: widget.id, id: widget._usersC[i].id, users: widget._usersC[i], message: widget._message, message_count: widget._messageCount),
                type: PageTransitionType.rightToLeft,
              ),
            );
          }
          widget._usersC.clear();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    _markers.add(
      Marker(
        markerId: MarkerId("S"),
        position: LatLng(double.parse(widget.ride.latS), double.parse(widget.ride.lonS)),
        icon: BitmapDescriptor.defaultMarkerWithHue(110)
      )
    );
    _markers.add(
      Marker(
        markerId: MarkerId("E"),
        position: LatLng(double.parse(widget.ride.latE), double.parse(widget.ride.lonE)),
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Icon(
          widget.ride.vehicle == 'Automóvil' ? Icons.drive_eta : Icons.motorcycle, size: 40
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              showChat();
            }, 
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: CameraPosition(
                target: LatLng((double.parse(widget.ride.latS) + double.parse(widget.ride.latE))/2, (double.parse(widget.ride.lonS) + double.parse(widget.ride.lonE))/2),
                zoom: 11,
              )
            ),
            color: Colors.grey,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.place),
                        title: Text(widget.ride.start + " - " + widget.ride.end),
                        subtitle: Text(widget.ride.dateAndTime),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.ride.plate), 
                            Text(widget.ride.color)
                          ],
                        )
                      ),
                      ListTile(
                        leading: Icon(Icons.money),
                        title: Text(widget.ride.price),
                        trailing: Column(
                          children: [
                            Icon(Icons.numbers), 
                            Text(widget.ride.room)
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
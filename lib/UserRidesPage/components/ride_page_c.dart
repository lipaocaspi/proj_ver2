import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/variables.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/UserRidesPage/components/passengers_page.dart';


class RidePageC extends StatefulWidget {
  RidePageC({Key? key, required this.id, required this.ride, required this.users}) : super(key: key);
  final int id;
  final Ride ride;
  final Users users;
  final List <Users> _usersP = [];

  @override
  State<RidePageC> createState() => _RidePageStateC();
}

class _RidePageStateC extends State<RidePageC> {
  bool isTapped = true;
  GoogleMapController? controller;
  List<Marker> _markers = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  showPass() async {
    widget._usersP.clear();
    final response = await http.get(Uri.parse("http://192.168.1.2:3000/users"));

    if (response.statusCode == 200) {
      List<dynamic> myUsers = json.decode(utf8.decode(response.bodyBytes));
      List<Users> user = myUsers.map((e) => Users.fromJson(e)).toList();
      setState(() {
        if(widget.ride.userP1Id != 0){
          widget._usersP.addAll(user.where((element) => element.id == widget.ride.userP1Id));
        }
        if(widget.ride.userP2Id != 0){
          widget._usersP.addAll(user.where((element) => element.id == widget.ride.userP2Id));
        }
        if(widget.ride.userP3Id != 0){
          widget._usersP.addAll(user.where((element) => element.id == widget.ride.userP3Id));
        }
        if(widget.ride.userP4Id != 0){
          widget._usersP.addAll(user.where((element) => element.id == widget.ride.userP4Id));
        }
      });
      if(widget._usersP.isEmpty){
        final nonSnack = SnackBar(
          content: Text("Este viaje no tiene pasajeros"),
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(nonSnack);
      } else {
        Navigator.of(context).push(
          PageTransition(
            child: PassengersPage(id: widget.id, widget._usersP, ride: widget.ride),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }
    }
  }

  upStateR(id) async {
    final res = await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": widget.ride.userP1Id,
        "userP2Id": widget.ride.userP2Id,
        "userP3Id": widget.ride.userP3Id,
        "userP4Id": widget.ride.userP4Id,
        "start": widget.ride.start,
        "latS": widget.ride.latS,
        "lonS":  widget.ride.lonS,
        "end": widget.ride.end,
        "latE": widget.ride.latE,
        "lonE": widget.ride.lonE,
        "dateAndTime": widget.ride.dateAndTime,
        "vehicle": widget.ride.vehicle,
        "room": widget.ride.room,
        "color": widget.ride.color,
        "plate": widget.ride.plate,
        "price": widget.ride.price,
        "state": widget.ride.state,
        "stateR": true
      })
    );
    if (res.statusCode == 200) {
      final onSnack = SnackBar(
          content: Text("El viaje está en curso"),
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(onSnack);
    }
  }

  upState(id) async {
    final res = await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": widget.ride.userP1Id,
        "userP2Id": widget.ride.userP2Id,
        "userP3Id": widget.ride.userP3Id,
        "userP4Id": widget.ride.userP4Id,
        "start": widget.ride.start,
        "latS": widget.ride.latS,
        "lonS":  widget.ride.lonS,
        "end": widget.ride.end,
        "latE": widget.ride.latE,
        "lonE": widget.ride.lonE,
        "dateAndTime": widget.ride.dateAndTime,
        "vehicle": widget.ride.vehicle,
        "room": widget.ride.room,
        "color": widget.ride.color,
        "plate": widget.ride.plate,
        "price": widget.ride.price,
        "state": true,
        "stateR": widget.ride.stateR
      })
    );
    if (res.statusCode == 200) {
      final onSnack = SnackBar(
          content: Text("El viaje ha finalizado"),
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(onSnack);
    }
  }

  startRide() async {
    if(widget.ride.state == false && widget.ride.stateR == true) {
      await upState(widget.ride.id);
      setState(() {
        isOn =  false;
      });
    }
    if (widget.ride.state == false && widget.ride.stateR == false) {
      await upStateR(widget.ride.id);
      setState(() {
        isOn =  true;
      });
    }
    if (widget.ride.state == true && widget.ride.stateR == true) {
      final doneSnack = SnackBar(
        content: Text("El viaje ya se ha realizado"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(doneSnack);
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
            icon: (isOn) ? Icon(Icons.stop) : Icon(Icons.play_arrow),
            onPressed: () async {
              await startRide();
            }, 
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () async {
              await showPass();
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

class RidePage extends StatefulWidget {
  RidePage({Key? key, required this.id, required this.ride, required this.users, required this.usersL}) : super(key: key);
  final int id;
  final Ride ride;
  final Users users;
  final List <Users> usersL;

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  GoogleMapController? controller;
  List<Marker> _markers = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  addPassenger(id) async {
    int r = int.parse(widget.ride.room);

    final fullSnack = SnackBar(
      content: Text("Viaje lleno"),
      action: SnackBarAction(
        label: "Cerrar",
        onPressed: () {
           Navigator.of(context);
        },
      ),
    );
    final doneSnack = SnackBar(
      content: Text("Eres parte del viaje"),
      action: SnackBarAction(
        label: "Cerrar",
        onPressed: () {
           Navigator.of(context);
        },
      ),
    );
    final alreadySnack = SnackBar(
      content: Text("Ya eres parte de este viaje"),
      action: SnackBarAction(
        label: "Cerrar",
        onPressed: () {
           Navigator.of(context);
        },
      ),
    );
    final onSnack = SnackBar(
      content: Text("El viaje está en curso"),
      action: SnackBarAction(
        label: "Cerrar",
        onPressed: () {
           Navigator.of(context);
        },
      ),
    );

    if(widget.ride.stateR == false) {
      if(widget.ride.userId != widget.users.id) {
        if(widget.ride.userP1Id == 0) {
          await http.put(Uri.parse("http://192.168.1.39:3000/rides/$id"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(<String, dynamic>{
              "id": widget.ride.id,
              "userId": widget.ride.userId,
              "userP1Id": widget.users.id,
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
              "stateR": widget.ride.stateR
            })
          );
          ScaffoldMessenger.of(context).showSnackBar(doneSnack);
        } else {
          if(widget.ride.userP2Id == 0) {
            if(r == 2 || r == 3 || r == 4) {
              if(widget.ride.userP1Id != widget.users.id){
                await http.put(Uri.parse("http://192.168.1.39:3000/rides/$id"),
                  headers: {"Content-Type": "application/json"},
                  body: jsonEncode(<String, dynamic>{
                    "id": widget.ride.id,
                    "userId": widget.ride.userId,
                    "userP1Id": widget.ride.userP1Id,
                    "userP2Id": widget.users.id,
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
                    "stateR": widget.ride.stateR
                  })
                );
                ScaffoldMessenger.of(context).showSnackBar(doneSnack);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(alreadySnack);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(fullSnack);
            }
          } else {
            if(widget.ride.userP3Id == 0) {
              if(r == 3 || r == 4) {
                if(widget.ride.userP2Id != widget.users.id && widget.ride.userP1Id != widget.users.id) {
                  await http.put(Uri.parse("http://192.168.1.39:3000/rides/$id"),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(<String, dynamic>{
                      "id": widget.ride.id,
                      "userId": widget.ride.userId,
                      "userP1Id": widget.ride.userP1Id,
                      "userP2Id": widget.ride.userP2Id,
                      "userP3Id": widget.users.id,
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
                      "stateR": widget.ride.stateR
                    })
                  );
                  ScaffoldMessenger.of(context).showSnackBar(doneSnack);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(alreadySnack);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(fullSnack);
              }
            } else {
              if(widget.ride.userP4Id == 0) {
                if(r == 4) {
                  if(widget.ride.userP3Id != widget.users.id && widget.ride.userP2Id != widget.users.id && widget.ride.userP1Id != widget.users.id) {
                    await http.put(Uri.parse("http://192.168.1.39:3000/rides/$id"),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode(<String, dynamic>{
                        "id": widget.ride.id,
                        "userId": widget.ride.userId,
                        "userP1Id": widget.ride.userP1Id,
                        "userP2Id": widget.ride.userP2Id,
                        "userP3Id": widget.ride.userP4Id,
                        "userP4Id": widget.users.id,
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
                        "stateR": widget.ride.stateR
                      })
                    );
                    ScaffoldMessenger.of(context).showSnackBar(doneSnack);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(alreadySnack);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(fullSnack);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(fullSnack);
              }
            }
          }
        }
      } else {}
    } else {
      ScaffoldMessenger.of(context).showSnackBar(onSnack);
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
            icon: Icon(widget.ride.state == false && widget.ride.userId != widget.users.id ? Icons.add : null),
            onPressed: () {
              addPassenger(widget.id);
            },
          ),
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
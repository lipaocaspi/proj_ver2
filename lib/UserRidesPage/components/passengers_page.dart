import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/data/repository/models/messages_model.dart';
import 'package:proj_ver1/UserRidesPage/components/selected_message_p.dart';

// ignore: must_be_immutable
class PassengersPage extends StatefulWidget {
  PassengersPage(this._users, {Key? key, required this.id, required this.ride}) : super(key: key);
  int id;
  List<Users> _users = [];
  final Ride ride;
  final List<Message> _message = [];
  final List<Message> _messageCount = [];

  @override
  State<PassengersPage> createState() => PassengersPageState();
}

class PassengersPageState extends State<PassengersPage> {

  showInfo(index) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget._users[index].name, 
            style: TextStyle(fontSize: 23), 
            textAlign: TextAlign.center
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget._users[index].icon),
                radius: 60,
              )
            ],
          ),
        );
      }
    );
  }

  showChat(index) async {
    widget._message.clear();
    widget._messageCount.clear();
    final response = await http.get(Uri.parse("http://192.168.1.2:3000/messages"));

    if (response.statusCode == 200) {
      List<dynamic> myMessages = json.decode(utf8.decode(response.bodyBytes));
      List<Message> message = myMessages.map((e) => Message.fromJson(e)).toList();
      setState(() {
        widget._messageCount.addAll(message);
        widget._message.addAll(message.where((element) => element.userIdOne == widget._users[index].id || element.userIdTwo == widget._users[index].id));
      });
      Navigator.of(context).push(
        PageTransition(
          child: MessagePage(idU: widget.id, id: widget._users[index].id, users: widget._users[index], message: widget._message, message_count: widget._messageCount),
          type: PageTransitionType.rightToLeft,
        ),
      );
    }
  }

  confirmDelete(index, i) {
    if(widget.ride.stateR == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("¿Desea eliminar al pasajero?",
                    style: TextStyle(fontSize: 20), 
                    textAlign: TextAlign.center
                  ),
            actions: <Widget> [
              TextButton(
                child: Text("CANCELAR", style: TextStyle(color: Colors.black)), 
                onPressed: () {
                  Navigator.pop(context);
                }
              ),
              TextButton(
                child: Text("CONFIRMAR", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  if(i == widget.ride.userP1Id) {
                    deletePassenger1(widget.ride.id);
                    Navigator.pop(context);
                  }
                  if(i == widget.ride.userP2Id) {
                    deletePassenger2(widget.ride.id);
                    Navigator.pop(context);
                  }
                  if(i == widget.ride.userP3Id) {
                    deletePassenger3(widget.ride.id);
                    Navigator.pop(context);
                  }
                  if(i == widget.ride.userP4Id) {
                    deletePassenger4(widget.ride.id);
                    Navigator.pop(context);
                  }
                  setState(() {
                    widget._users.removeAt(index);
                  });
                }, 
              )
            ]
          );
        }
      );
    } else {
      if(widget.ride.stateR == true && widget.ride.state == true) {
        final endSnack = SnackBar(
          content: Text("Viaje finalizado. No se puede eliminar"),
          action: SnackBarAction(
            label: "Cerrar",
              onPressed: () {
                Navigator.of(context);
              },
            ),
        );
        ScaffoldMessenger.of(context).showSnackBar(endSnack);
      } else {
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
  }

  deletePassenger1(id) async {
    await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": 0,
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
  }

  deletePassenger2(id) async {
    await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": widget.ride.userP1Id,
        "userP2Id": 0,
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
  }

  deletePassenger3(id) async {
    await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": widget.ride.userP1Id,
        "userP2Id": widget.ride.userP2Id,
        "userP3Id": 0,
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
  }

  deletePassenger4(id) async {
    await http.put(Uri.parse("http://192.168.1.2:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.ride.id,
        "userId": widget.ride.userId,
        "userP1Id": widget.ride.userP1Id,
        "userP2Id": widget.ride.userP2Id,
        "userP3Id": widget.ride.userP3Id,
        "userP4Id": 0,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pasajeros"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.8,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: widget._users.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey.shade100,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(widget._users[index].icon),
                                  radius: 23,
                                ),
                                title: Text(
                                  widget._users[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {
                                      showInfo(index);
                                    }, 
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () async {
                                      await showChat(index);
                                    }, 
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      int i = widget._users[index].id;
                                      confirmDelete(index, i);
                                    }, 
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
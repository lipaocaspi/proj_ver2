import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/UserRidesPage/components/edit_ride.dart';
import 'package:proj_ver1/UserRidesPage/components/ride_page_c.dart';
import 'package:proj_ver1/UserRidesPage/components/ride_page_p.dart';
import 'package:proj_ver1/variables.dart';

// ignore: must_be_immutable
class UserRidesPage extends StatefulWidget {
  UserRidesPage(this.id, this._ridesU, this._ridesP, this.users, {Key? key}) : super(key: key);
  int id;
  List<Ride> _ridesU = [];
  List<Ride> _ridesP = [];
  Users users;

  @override
  State<UserRidesPage> createState() => UserRidesPageState();
}

class UserRidesPageState extends State<UserRidesPage> {

  reloadRides() async {
    widget._ridesU.clear();
    widget._ridesP.clear();
    final response = await http.get(Uri.parse("http://192.168.1.39:3000/rides"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget._ridesU.addAll(rides.where((element) => widget.id == element.userId));
        widget._ridesP.addAll(rides.where((element) => element.userP1Id == widget.id || element.userP2Id == widget.id || element.userP3Id == widget.id || element.userP4Id == widget.id));
      });
      final upSnack = SnackBar(
        content: Text("Viajes actualizados"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(upSnack);
    }
  }

  editRide(index) {
    if(widget._ridesU[index].state == true && widget._ridesU[index].stateR == true) {
      final errorEditSnack = SnackBar(
        content: Text("Viaje finalizado. No se puede editar"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorEditSnack);
    }
    else {
      if (widget._ridesU[index].state == false && widget._ridesU[index].stateR == true) {
        final errorEdSnack = SnackBar(
          content: Text("Viaje en curso. No se puede editar"),
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(errorEdSnack);
      } else {
        Navigator.of(context).push(
          PageTransition(
            child: EditRidePage(widget._ridesU[index], users: widget.users),
            type: PageTransitionType.bottomToTop,
          ),
        );
      }
    }
  }

  confirmDelete(index, id) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "¿Desea eliminar el viaje?",
            style: TextStyle(fontSize: 20), 
            textAlign: TextAlign.center
          ),
          actions: <Widget>[
            TextButton(
              child: Text("CANCELAR", style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pop(context);
              }, 
            ),
            TextButton(
              child: Text("CONFIRMAR", style: TextStyle(color: Colors.black)),
              onPressed: () {
                deleteRide(index, id);
                Navigator.pop(context);
              }, 
            )
          ],
        );
      }
    );
  }

  deleteRide(index, id) async {
    final response = await http.delete(Uri.parse("http://192.168.1.39:3000/rides/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      setState(() {
        widget._ridesU.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Pasajero"),
              Tab(text: "Conductor"),
            ],
          ),
          title: Text("Mis Viajes"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                reloadRides();
              }, 
            )
          ],
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.7,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: widget._ridesP.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(widget._ridesP[index].vehicle == 'Motocicleta' ? Icons.motorcycle : Icons.drive_eta),
                                    title: Text(widget._ridesP[index].start + " - " + widget._ridesP[index].end),
                                    subtitle: Text(widget._ridesP[index].dateAndTime),
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: RidePageP(ride: widget._ridesP[index], id: widget.users.id, users: widget.users),
                                          type: PageTransitionType.rightToLeft,
                                        ),
                                      );
                                    },
                                    visualDensity: VisualDensity(vertical: -3),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(widget._ridesP[index].color),
                                        Text(widget._ridesP[index].plate),
                                      ],
                                    )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        widget._ridesP[index].state == false && widget._ridesP[index].stateR == true ? Icons.play_arrow :
                                        widget._ridesP[index].state == true && widget._ridesP[index].stateR == true ? Icons.check : null,
                                        color: Colors.green,
                                        size: 35,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.7,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: widget._ridesU.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(widget._ridesU[index].vehicle == 'Motocicleta' ? Icons.motorcycle : Icons.drive_eta),
                                    title: Text(widget._ridesU[index].start + " - " + widget._ridesU[index].end),
                                    subtitle: Text(widget._ridesU[index].dateAndTime),
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    onTap: () {
                                      if(widget._ridesU[index].stateR == false) {
                                        setState(() {
                                          isOn = false;
                                        });
                                      }
                                      else {
                                        if(widget._ridesU[index].state == true) {
                                          setState(() {
                                            isOn = false;
                                          });
                                        } else {
                                          setState(() {
                                            isOn = true;
                                          });
                                        }
                                      }
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: RidePageC(ride: widget._ridesU[index], id: widget.users.id, users: widget.users),
                                          type: PageTransitionType.rightToLeft,
                                        ),
                                      );
                                    },
                                    visualDensity: VisualDensity(vertical: -3),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(widget._ridesU[index].color),
                                        Text(widget._ridesU[index].plate),
                                      ],
                                    )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(widget._ridesU[index].state == true && widget._ridesU[index].stateR == true ? null : Icons.edit),
                                        onPressed: (){
                                          editRide(index);
                                        }, 
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){
                                          if(widget._ridesU[index].stateR == true && widget._ridesU[index].state == false) {
                                            final errorDeSnack = SnackBar(
                                              content: Text("Viaje en curso. No se puede eliminar"),
                                              action: SnackBarAction(
                                                label: "Cerrar",
                                                onPressed: () {
                                                  Navigator.of(context);
                                                },
                                              ),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(errorDeSnack);
                                          } else {
                                            confirmDelete(index, widget._ridesU[index].id);
                                          }
                                        }, 
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      )
    );
  }
}
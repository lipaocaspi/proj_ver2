import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:proj_ver1/variables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/UserRidesPage/components/edit_ride_map_e.dart';
import 'package:proj_ver1/UserRidesPage/components/edit_ride_map_s.dart';

class EditRidePage extends StatefulWidget {
  EditRidePage(this.ride, {Key? key, required this.users}) : super(key: key);
  final Ride ride;
  final Users users;

  @override
  EditRidePageState createState() => EditRidePageState();
}

class EditRidePageState extends State<EditRidePage> {
  final TextEditingController _controllerStart = TextEditingController();
  final TextEditingController _controllerEnd = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerRoom = TextEditingController();
  final TextEditingController _controllerColor = TextEditingController();
  final TextEditingController _controllerPlate = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final vehicle = ["Automóvil", "Motocicleta"];
  final _keyForm = GlobalKey<FormState>();

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  updateRide(id) async {
    final response = await http.put(Uri.parse("http://192.168.1.41:3000/rides/$id"),
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
        "stateR": widget.ride.stateR
      })
    );
    if(response.statusCode == 200) {
      setState(() {
        start = "";
        end = "";
      });
      Navigator.of(context).pop();
      final upSnack = SnackBar(
        content: Text("Se ha actualizado correctamente")
      );
      ScaffoldMessenger.of(context).showSnackBar(upSnack);
    }
  }

  String? value1;
  DropdownMenuItem<String> buildMenuVehicle(String vehicle) => DropdownMenuItem(
    value: vehicle,
    child: Text(
      vehicle,
      style: const TextStyle(fontSize: 15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Viaje"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            if(_keyForm.currentState!.validate()) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                updateRide(widget.ride.id);
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _controllerStart..text = widget.ride.start,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.room),
                          )
                        ),
                        enabled: false,
                        validator: ValidationBuilder().build(),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Icon(Icons.map),
                        onPressed: () async {
                          getUserCurrentLocation().then(
                            (value) async {
                              final location = await
                              Navigator.of(context).push(
                                PageTransition(
                                  child: EditRideMapS(value: value, ride: widget.ride),
                                  type: PageTransitionType.fade,
                                ),
                              );
                              setState(() {
                                widget.ride.start = location;
                                widget.ride.latS = latS;
                                widget.ride.lonS = lonS;
                              });
                            }
                          );
                        },
                      )
                    )
                  )
                ],
              ),
              space,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _controllerEnd..text = widget.ride.end,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.room),
                          )
                        ),
                        enabled: false,
                        validator: ValidationBuilder().build(),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Icon(Icons.map),
                        onPressed: () {
                          getUserCurrentLocation().then(
                            (value) async {
                              final location = await
                              Navigator.of(context).push(
                                PageTransition(
                                  child: EditRideMapE(value: value, ride: widget.ride),
                                  type: PageTransitionType.fade,
                                ),
                              );
                              setState(() {
                                widget.ride.end = location;
                                widget.ride.latE = latE;
                                widget.ride.lonE = lonE;
                              });
                            }
                          );
                        },
                      )
                    )
                  )
                ],
              ),
              space,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _controllerDate..text = widget.ride.dateAndTime,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.calendar_month),
                          )
                        ),
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Por favor ingrese la fecha y hora").regExp(RegExp(r"^([0-9]|[1-2][0-9]|(3)[0-1])(\/)(([0-9])|((1)[0-2]))(\/)\d{4} ([0-1]?[0-9]|2[0-3]):[0-5][0-9]"), "Ingrese una fecha válida").build(),
                        onFieldSubmitted: (value) {
                          setState(() {
                            widget.ride.dateAndTime = _controllerDate.text;
                          });
                        },
                      ),
                    )
                  ),
                ],
              ),
              space,
              Text(
                "Vehículo",
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              space,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        items: vehicle.map(buildMenuVehicle).toList(),
                        value: widget.ride.vehicle,
                        onChanged: (value) {
                          setState(() {
                            widget.ride.vehicle = value!;
                          });
                        },
                      ),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerRoom..text = widget.ride.room,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese los cupos").regExp(RegExp(r"^([1-4]$)"), "Número no válido").build(),
                        onFieldSubmitted: (value) {
                          setState(() {
                            widget.ride.room = _controllerRoom.text;
                          });
                        },
                      ),
                    )
                  )
                ],
              ),
              space,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerColor..text = widget.ride.color,
                        decoration: InputDecoration(hintText: "Color"),
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese el color").build(),
                        onFieldSubmitted: (value) {
                          setState(() {
                            widget.ride.color = _controllerColor.text;
                          });
                        },
                      ),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerPlate..text = widget.ride.plate,
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese la placa").regExp(RegExp(r"^([A-Z]{3}\d{3}$)|([A-Z]{3}\d{2}[A-Z]$)"), "Placa no válida").build(),
                        onFieldSubmitted: (value) {
                          setState(() {
                            widget.ride.plate = _controllerPlate.text;
                          });
                        },
                      ),
                    )
                  )
                ],
              ),
              space,
              TextFormField(
                controller: _controllerPrice..text = widget.ride.price,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.money),
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: ValidationBuilder(requiredMessage: "Por favor ingrese el valor").regExp(RegExp(r"^(\d{4})$"), "Precio no válido").build(),
                onFieldSubmitted: (value) {
                  setState(() {
                    widget.ride.price = _controllerPrice.text;
                  });
                },
              ),
            ],
          )
        )
      )
    );
  }
}
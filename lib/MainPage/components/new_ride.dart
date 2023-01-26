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
import 'package:proj_ver1/MainPage/components/new_ride_map_e.dart';
import 'package:proj_ver1/MainPage/components/new_ride_map_s.dart';

class NewRidePage extends StatefulWidget {
  NewRidePage({Key? key, required this.users}) : super(key: key);
  final Users users;
  final List<Ride> _ridesCount = [];

  @override
  NewRidePageState createState() => NewRidePageState();
}

class NewRidePageState extends State<NewRidePage> {
  final TextEditingController _controllerStart = TextEditingController();
  final TextEditingController _controllerEnd = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerRoom = TextEditingController();
  final TextEditingController _controllerColor = TextEditingController();
  final TextEditingController _controllerPlate = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final vehicle = ["Automóvil", "Motocicleta"];
  final formKey = GlobalKey<FormState>();
  late Ride newRide;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  postRide() async {
    final res = await http.get(Uri.parse("http://192.168.1.35:3000/rides"));
    if (res.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(res.bodyBytes));
      List<Ride> ride = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget._ridesCount.addAll(ride);
      });
      newRide = Ride(
        id: widget._ridesCount.length + 1,
        userId: widget.users.id,
        userP1Id: 0,
        userP2Id: 0,
        userP3Id: 0,
        userP4Id: 0,
        start: _controllerStart.text,
        latS: latS,
        lonS: lonS,
        end: _controllerEnd.text,
        latE: latE,
        lonE: lonE,
        dateAndTime: _controllerDate.text,
        vehicle: value1!,
        room: _controllerRoom.text,
        color: _controllerColor.text,
        plate: _controllerPlate.text,
        price: _controllerPrice.text,
        state: false,
        stateR: false,
      );
      final response = await http.post(Uri.parse("http://192.168.1.35:3000/rides"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "id": newRide.id,
          "userId": newRide.userId,
          "userP1Id": newRide.userP1Id,
          "userP2Id": newRide.userP2Id,
          "userP3Id": newRide.userP3Id,
          "userP4Id": newRide.userP4Id,
          "start": newRide.start,
          "latS": newRide.latS,
          "lonS": newRide.lonS,
          "end": newRide.end,
          "latE": newRide.latE,
          "lonE": newRide.lonE,
          "dateAndTime": newRide.dateAndTime,
          "vehicle": newRide.vehicle,
          "room": newRide.room,
          "color": newRide.color,
          "plate": newRide.plate,
          "price": newRide.price,
          "state": newRide.state,
          "stateR": newRide.stateR,
          })
      );
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        final successSnack = SnackBar(
          content: Text("Viaje creado con éxito")
        );
        ScaffoldMessenger.of(context).showSnackBar(successSnack);
      }
      setState(() {
        start = "";
        end = "";
      });
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
        title: const Text("Nuevo Viaje"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              start = '';
              end = '';
            });
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                postRide();
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _controllerStart..text = start,
                        decoration: const InputDecoration(
                          hintText: "Origen",
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
                                  child: NewRideMapS(value: value, users: widget.users),
                                  type: PageTransitionType.fade,
                                ),
                              );
                              setState(() {
                                start = location;
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
                        controller: _controllerEnd..text = end,
                        decoration: const InputDecoration(
                          hintText: "Destino",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.room),
                          )
                        ),
                        enabled: false,
                        textInputAction: TextInputAction.next,
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
                                  child: NewRideMapE(value: value, users: widget.users),
                                  type: PageTransitionType.fade,
                                ),
                              );
                              setState(() {
                                end = location;
                              });
                            }
                          );
                        },
                      )
                    ), 
                  )
                ],
              ),
              space,
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _controllerDate,
                  decoration: const InputDecoration(
                    hintText: "D/M/AAAA H:MM",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.calendar_month),
                    )
                  ),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  validator: ValidationBuilder(requiredMessage: "Por favor ingrese la fecha y hora").regExp(RegExp(r"^(([0-9])|[1-2][0-9]|(3)[0-1])(\/)(([0-9])|((1)[0-2]))(\/)\d{4} (00|[0-9]|1[0-9]|2[0-3]):([0-5][0-9])"), "Ingrese una fecha válida").build(),
                ),
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
                        value: value1,
                        validator: (value) => value == null ? 'Elija una opción' : null,
                        onChanged: (value) => setState(() => value1 = value),
                      ),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerRoom,
                        decoration: InputDecoration(hintText: "Cupos"),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese los cupos").regExp(RegExp(r"^([1-4]$)"), "Número no válido").build(),
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
                        controller: _controllerColor,
                        decoration: InputDecoration(hintText: "Color"),
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese el color").build(),
                      ),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: TextFormField(
                        controller: _controllerPlate,
                        decoration: InputDecoration(hintText: "Placa"),
                        textInputAction: TextInputAction.next,
                        validator: ValidationBuilder(requiredMessage: "Ingrese la placa").regExp(RegExp(r"^([A-Z]{3}\d{3}$)|([A-Z]{3}\d{2}[A-Z]$)"), "Placa no válida").build(),
                      ),
                    )
                  )
                ],
              ),
              space,
              TextFormField(
                controller: _controllerPrice,
                decoration: InputDecoration(
                  hintText: "Valor",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.money),
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: ValidationBuilder(requiredMessage: "Por favor ingrese el valor").regExp(RegExp(r"^(\d{4})$"), "Precio no válido").build(),
              ),
            ],
          ),
        ),
      )
    );
  }
}
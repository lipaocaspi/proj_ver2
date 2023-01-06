import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:form_validator/form_validator.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

class NewRidePage extends StatefulWidget {
  const NewRidePage({Key? key, required this.users}) : super(key: key);
  final Users users;

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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                postRide();
              }
            },
            icon: Icon(Icons.check)
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
                        controller: _controllerStart,
                        decoration: const InputDecoration(
                          hintText: "Origen",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.room),
                          )
                        ),
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
                        onPressed: () {},
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
                        controller: _controllerEnd,
                        decoration: const InputDecoration(
                          hintText: "Destino",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.room),
                          )
                        ),
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
                        onPressed: () {},
                      )
                    )
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
                  validator: ValidationBuilder().regExp(RegExp(r"^(([0-9])|[1-2][0-9]|(3)[0-1])(\/)(([0-9])|((1)[0-2]))(\/)\d{4} (00|[0-9]|1[0-9]|2[0-3]):([0-5][0-9])"), "Ingrese una fecha válida").build(),
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
                        validator: ValidationBuilder().regExp(RegExp(r"^([1-4]$)"), "Número no válido").build(),
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
                        validator: ValidationBuilder().build(),
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
                        validator: ValidationBuilder().regExp(RegExp(r"^([A-Z]{3}\d{3}$)|([A-Z]{3}\d{2}[A-Z]$)"), "Placa no válida").build(),
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
                validator: ValidationBuilder().regExp(RegExp(r"^(\d{4})$"), "Precio no válido").build(),
              ),
            ],
          ),
        ),
      )
    );
  }

  postRide() async {
    newRide = Ride(
      id: 20,
      userId: widget.users.id,
      start: _controllerStart.text,
      end: _controllerEnd.text,
      dateAndTime: _controllerDate.text,
      vehicle: value1!,
      room: _controllerRoom.text,
      color: _controllerColor.text,
      plate: _controllerPlate.text,
      price: _controllerPrice.text,
      state: false,
    );
    final response = await http.post(Uri.parse("http://192.168.1.37:3000/rides"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": newRide.id,
        "userId": newRide.userId,
        "start": newRide.start,
        "end": newRide.end,
        "dateAndTime": newRide.dateAndTime,
        "vehicle": newRide.vehicle,
        "room": newRide.room,
        "color": newRide.color,
        "plate": newRide.plate,
        "price": newRide.price,
        "state": newRide.state,
        })
    );
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      final successSnack = SnackBar(
        content: Text("Viaje creado con éxito"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(successSnack);
    }
  }
}

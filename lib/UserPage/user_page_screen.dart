import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:form_validator/form_validator.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

class UserPage extends StatefulWidget {
  UserPage(this.users, {Key? key}) : super(key: key);
  final Users users;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _keyForm = GlobalKey<FormState>();

  static final icondecoration = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(50)),
    boxShadow: [
      BoxShadow(
        blurRadius: 3,
        color: Colors.black.withOpacity(0.3),
        offset: Offset(2, 4),
      )
    ],
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Stack(
                    alignment: Alignment.center, 
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 57,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(widget.users.icon),
                          radius: 55,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: MediaQuery.of(context).size.width * 0.25,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(Icons.edit, size: 20)
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(2, 4),
                                )
                              ]
                            ),
                          )
                        )
                      )
                    ]
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.drive_eta, size: 30)
                        ),
                        decoration: icondecoration,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.motorcycle, size: 30)
                        ),
                        decoration: icondecoration,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.star, size: 30)
                        ),
                        decoration: icondecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.users.name,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.person),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: ValidationBuilder().build(),
                          onChanged: (value) {
                            setState(() {
                              if (_keyForm.currentState!.validate()) {
                                widget.users.name = value;
                                updateUser(widget.users.id);
                              }
                            });
                          },
                        ),
                        space,
                        TextFormField(
                          initialValue: widget.users.dateOfBirth,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.calendar_month),
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          validator: ValidationBuilder().regExp(RegExp(r"^([0-9]|[1-2][0-9]|(3)[0-1])(\/)(([0-9])|((1)[0-2]))(\/)\d{4}"), "Ingrese una fecha válida").build(),
                          onChanged: (value) {
                            setState(() {
                              if (_keyForm.currentState!.validate()) {
                                widget.users.dateOfBirth = value;
                                updateUser(widget.users.id);
                              }
                            });
                          },
                        ),
                        space,
                        TextFormField(
                          initialValue: widget.users.email,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.email),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          validator: ValidationBuilder().email().build(),
                          onChanged: (value) {
                            setState(() {
                              if (_keyForm.currentState!.validate()) {
                                widget.users.email = value;
                                updateUser(widget.users.id);
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ),
                ],
              )
            )
          ),
        ],
      ),
    );
  }

  updateUser(id) async {
    http.put(Uri.parse("http://192.168.1.37:3000/users/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": widget.users.id,
        "name": widget.users.name,
        "dateOfBirth": widget.users.dateOfBirth,
        "email": widget.users.email,
        "icon": widget.users.icon,
        "password": widget.users.password
      })
    );
  }
}

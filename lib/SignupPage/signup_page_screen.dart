import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:proj_ver1/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/MainPage/main_page_screen.dart';
import 'package:proj_ver1/LoginPage/login_page_screen.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  final List<Ride> _rides = [];
  final List<Ride> _ridesU = [];
  final List<Ride> _ridesP = [];
  final List<Users> _usersCount = [];

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBirth = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConf = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  late Users newUser;

  validate () async {
    final response = await http.get(Uri.parse("http://192.168.1.39:3000/users?email=$email"));
    if (response.statusCode == 200) {
      List<dynamic> myUser = json.decode(response.body);
      List<Users> user = myUser.map((e) => Users.fromJson(e)).toList();
      if (user.isEmpty) {
        if (_controllerPassword.text == _controllerPasswordConf.text) {
          postUser();
        } else {
          final passSnack = SnackBar(
            content: Text("Las contraseñas no coinciden"),
            action: SnackBarAction(
              label: "Cerrar",
              onPressed: () {
                Navigator.of(context);
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(passSnack);
        }
      } else {
        final emailSnack = SnackBar(
          content: Text("Este correo ya se encuentra registrado"),
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(emailSnack);
      }
      return;
    }
  }

  postUser() async {
    final res = await http.get(Uri.parse("http://192.168.1.39:3000/users"));
    if(res.statusCode == 200) {
      List<dynamic> myUsers = json.decode(utf8.decode(res.bodyBytes));
      List<Users> users = myUsers.map((e) => Users.fromJson(e)).toList();
      setState(() {
        widget._usersCount.addAll(users);
      });
      newUser = Users(
        id: widget._usersCount.length + 1,
        name: _controllerName.text,
        dateOfBirth: _controllerBirth.text,
        email: _controllerEmail.text,
        icon: "https://cdn.icon-icons.com/icons2/67/PNG/512/user_13230.png",
        password: _controllerPassword.text
      );
      final response = await http.post(Uri.parse("http://192.168.1.39:3000/users"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "id": newUser.id,
          "name": newUser.name,
          "dateOfBirth": newUser.dateOfBirth,
          "email": newUser.email,
          "icon": newUser.icon,
          "password": newUser.password,
        })
      );
      if (response.statusCode == 201) {
        widget._rides.clear();
        widget._ridesU.clear();
        widget._ridesP.clear();
        final response = await http.get(Uri.parse("http://192.168.1.39:3000/rides"));

        if (response.statusCode == 200) {
          List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
          List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
          setState(() {
            widget._rides.addAll(rides.where((element) => element.state == false && newUser.id != element.userId));
            widget._ridesU.addAll(rides.where((element) => newUser.id == element.userId));
            widget._ridesP.addAll(rides.where((element) => element.userP1Id == newUser.id || element.userP2Id == newUser.id || element.userP3Id == newUser.id || element.userP4Id == newUser.id));
          });
          Navigator.of(context).push(
            PageTransition(
              child: MainPage(id: newUser.id, users: newUser, ridesA: widget._rides, ridesU: widget._ridesU, ridesP: widget._ridesP),
              type: PageTransitionType.fade,
            ),
          );
          final successSnack = SnackBar(
            content: Text("Usuario creado con éxito"),
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: kBackgroundColor,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                        Text(
                          "Registro",
                          style: GoogleFonts.pressStart2p(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        morespace,
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            controller: _controllerName,
                            decoration: const InputDecoration(
                              hintText: "Nombre",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.person),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: ValidationBuilder(requiredMessage: "Por favor ingrese el nombre").build(),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Fecha de Nacimiento",
                          textAlign: TextAlign.center
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            controller: _controllerBirth,
                            decoration: const InputDecoration(
                              hintText: "D/M/AAAA",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.calendar_month),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            validator: ValidationBuilder(requiredMessage: "Por favor ingrese la fecha de nacimiento").regExp(RegExp(r"^([0-9]|[1-2][0-9]|(3)[0-1])(\/)(([0-9])|((1)[0-2]))(\/)\d{4}"), "Ingrese una fecha válida").build(),
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            controller: _controllerEmail,
                            decoration: const InputDecoration(
                              hintText: "Correo",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.mail),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: ValidationBuilder(requiredMessage: "Por favor ingrese el correo").email().build(),
                            onChanged: (value) {
                              setState(() {
                                email = _controllerEmail.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            controller: _controllerPassword,
                            decoration: const InputDecoration(
                              hintText: "Contraseña",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.lock),
                              ),
                            ),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: ValidationBuilder(requiredMessage: "Por favor ingrese la contraseña").build(),
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: ValidationBuilder(requiredMessage: "Por favor confirme la contraseña").build(),
                            controller: _controllerPasswordConf,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Confirmar contraseña",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.lock),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50, right: 5),
                                child: ElevatedButton(
                                  child: Icon(
                                    Icons.login,
                                    color: kButtonPrimaryColor
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 242, 255, 239),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: LoginPage(),
                                        type: PageTransitionType.fade,
                                      ),
                                    );
                                  },
                                )
                              )
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 50),
                                child: ElevatedButton(
                                  child: Text("Registrarse".toUpperCase()),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 45),
                                  ),
                                  onPressed: () async {
                                    if (_keyForm.currentState!.validate()) {
                                      validate();
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
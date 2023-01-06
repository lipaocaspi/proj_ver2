import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/variables.dart';
import 'package:proj_ver1/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/MainPage/main_page_screen.dart';
import 'package:proj_ver1/SignupPage/signup_page_screen.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: kBackgroundColor,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
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
                          "Ingreso",
                          style: GoogleFonts.pressStart2p(fontSize: 15), 
                          textAlign: TextAlign.center
                        ),
                        morespace,
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                "assets/images/llanta.png",
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        morespace,
                        Padding(
                          padding: EdgeInsets.only(left: 35, right: 35),
                          child: TextFormField(
                            controller: _controllerEmail,
                            decoration: const InputDecoration(
                              hintText: "Correo",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.email),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: ValidationBuilder().email().build(),
                            onChanged: (value) {
                              setState(() {
                                email = _controllerEmail.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
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
                            textInputAction: TextInputAction.done,
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              setState(() {
                                password = _controllerPassword.text;
                              });
                            },
                          ),
                        ),
                        morespace,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50, right: 5),
                                child: ElevatedButton(
                                  child: Icon(
                                    Icons.person_add,
                                    color: kButtonPrimaryColor
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 242, 255, 239),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: const SignUpPage(),
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
                                  child: Text("Ingresar".toUpperCase()),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 45),
                                  ),
                                  onPressed: () async {
                                    if (_keyForm.currentState!.validate()) {
                                      final response = await http.get(Uri.parse("http://192.168.1.37:3000/users?email=$email&password=$password"));
                                      if (response.statusCode == 200) {
                                        List<dynamic> myUser = json.decode(response.body);
                                        List<Users> user = myUser.map((e) => Users.fromJson(e)).toList();
                                        if (user.isEmpty) {
                                          final credentialsSnack = SnackBar(
                                            content: Text("Las credenciales son incorrectas"),
                                            action: SnackBarAction(
                                              label: "Cerrar",
                                              onPressed: () {
                                                Navigator.of(context);
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(credentialsSnack);
                                        } else {
                                          int id = user[0].id;
                                          Navigator.of(context).push(
                                            PageTransition(
                                              child: MainPage(id: id, users: user[0]),
                                              type: PageTransitionType.fade,
                                            ),
                                          );
                                        }
                                        return ;
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:proj_ver1/variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:page_transition/page_transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proj_ver1/LoginPage/login_page_screen.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

// ignore: must_be_immutable
class PrivacyPage extends StatefulWidget {
  PrivacyPage(this.users, this._ridesU, {Key? key}) : super(key: key);
  final Users users;
  List<Ride> _ridesU = [];

  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  final _formkey_up = GlobalKey<FormState>();
  final _formkey_de = GlobalKey<FormState>();

  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  Future<bool> requestLocationPermission() async {
    PermissionStatus resultLoc;
    if (isSwitchOnLoc == true) {
      resultLoc = await Permission.location.request();
      if (resultLoc.isGranted) {
        setState(() {
          isSwitchOnLoc = true;
        });
      } else if (resultLoc.isDenied) {
        setState(() {
          isSwitchOnLoc = false;
        });
      }
    }
    return true;
  }

  Future<bool> requestCameraPermission() async {
    var statusCam = await Permission.camera.status;
    PermissionStatus resultCam;
    if (isSwitchOnCam == true && statusCam.isDenied) {
      resultCam = await Permission.camera.request();
      if (resultCam.isGranted) {
        setState(() {
          isSwitchOnCam = true;
        });
      } else if (resultCam.isDenied) {
        setState(() {
          isSwitchOnCam = false;
        });
      }
    }
    return true;
  }

  Future<bool> requestStoragePermission() async {
    var statusSto = await Permission.storage.status;
    PermissionStatus resultSto;
    if (isSwitchOnSto == true && statusSto.isDenied) {
      resultSto = await Permission.storage.request();
      if (resultSto.isGranted) {
      } else if (resultSto.isDenied) {
        setState(() {
          isSwitchOnSto = false;
        });
      }
    }
    return true;
  }

  updateUserPassword(id) async {
    final response = await http.put(Uri.parse("http://192.168.1.35:3000/users/$id"),
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
    if(response.statusCode == 200) {
      Navigator.pop(context);
      final successUpSnack = SnackBar(
        content: Text("Contraseña actualizada"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(successUpSnack);
    }
  }

  deleteUser(id) async {
    final response = await http.delete(
      Uri.parse("http://192.168.1.35:3000/users/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final successDelSnack = SnackBar(
        content: Text("Se ha borrado exitosamente"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      if(widget._ridesU.isNotEmpty) {
        for(var i = 0; i == widget._ridesU.length; i++){
          id = widget._ridesU[i].id;
          http.delete(Uri.parse("http://192.168.1.35:3000/rides/$id"));
        }
        Navigator.of(context).push(
          PageTransition(
            child: LoginPage(),
            type: PageTransitionType.fade,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(successDelSnack);
      } else {
        Navigator.of(context).push(
          PageTransition(
            child: LoginPage(),
            type: PageTransitionType.fade,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(successDelSnack);
      }
    }
  }

  static final bdecoration = BoxDecoration(
    color: Colors.grey.withOpacity(0.1),
  );

  static final tdecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: const Color.fromARGB(255, 197, 197, 197),
  );

  static final whiteBox = SizedBox(height: 5, child: Container(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    Widget errorPToast() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: tdecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.person, color: Colors.black87),
          SizedBox(width: 10.0),
          Text(
            'La contraseña es incorrecta',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );

    Widget errorCToast() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: tdecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.person, color: Colors.black87),
          SizedBox(width: 10.0),
          Text(
            'Las contraseñas no coinciden',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );

    void showCoToast() => toast.showToast(
      child: errorCToast(),
      gravity: ToastGravity.BOTTOM,
    );

    void showEToast() => toast.showToast(
      child: errorPToast(),
      gravity: ToastGravity.BOTTOM,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacidad"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: bdecoration,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.perm_device_info),
                            )
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Permisos del sistema")
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.place),
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Ubicación")
                            )
                          ),
                          Expanded(
                            child: FlutterSwitch(
                              activeColor: Colors.green,
                              activeIcon: Icon(Icons.check, color: Colors.green),
                              inactiveIcon: Icon(Icons.close, color: Colors.grey),
                              value: isSwitchOnLoc,
                              onToggle: (value) {
                                setState(() {
                                  isSwitchOnLoc = true;
                                });
                                if (isSwitchOnLoc == true) {
                                  requestLocationPermission();
                                };
                              },
                            )
                          )
                        ],
                      ),
                      space,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.camera_alt),
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Cámara")
                            )
                          ),
                          Expanded(
                            child: FlutterSwitch(
                              activeColor: Colors.green,
                              activeIcon: Icon(Icons.check, color: Colors.green),
                              inactiveIcon: Icon(Icons.close, color: Colors.grey),
                              value: isSwitchOnCam,
                              onToggle: (value) {
                                setState(() {
                                  isSwitchOnCam = true;
                                });
                                if (isSwitchOnCam == true) {
                                  requestCameraPermission();
                                }
                                ;
                              },
                            )
                          )
                        ],
                      ),
                      space,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.folder),
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Almacenamiento")
                            )
                          ),
                          Expanded(
                            child: FlutterSwitch(
                              activeColor: Colors.green,
                              activeIcon: Icon(Icons.check, color: Colors.green),
                              inactiveIcon: Icon(Icons.close, color: Colors.grey),
                              value: isSwitchOnSto,
                              onToggle: (value) {
                                setState(() {
                                  isSwitchOnSto = true;
                                });
                                if (isSwitchOnSto == true) {
                                  requestStoragePermission();
                                }
                                ;
                              },
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  decoration: bdecoration,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        expand: true,
                        context: context,
                        builder: (context) {
                          return Form(
                            key: _formkey_up,
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: ListView(
                                children: <Widget>[
                                  Text(
                                    "Cambiar contraseña",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                                  ),
                                  doublespace,
                                  Text(
                                    "Ingrese la contraseña actual, seguida de la nueva.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  space,
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Contraseña actual",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.lock),
                                      )
                                    ),
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationBuilder(requiredMessage: "Por favor ingrese la contraseña actual").build(),
                                    onChanged: (value) {
                                      setState(() {
                                        currentPass = value;
                                      });
                                    },
                                  ),
                                  space,
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Contraseña nueva",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.lock),
                                      )
                                    ),
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationBuilder(requiredMessage: "Por favor ingrese la contraseña nueva").build(),
                                    onChanged: (value) {
                                      setState(() {
                                        newPass = value;
                                      });
                                    },
                                  ),
                                  space,
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Confirme la contraseña",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.lock),
                                      )
                                    ),
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    validator: ValidationBuilder(requiredMessage: "Por favor confirme la contraseña").build(),
                                    onChanged: (value) {
                                      setState(() {
                                        confnewPass = value;
                                      });
                                    },
                                  ),
                                  doublespace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: ElevatedButton(
                                            child: Icon(Icons.cancel),
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: ElevatedButton(
                                            child: Icon(Icons.save),
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                            onPressed: () {
                                              if (_formkey_up.currentState!.validate()) {
                                                if (currentPass == widget.users.password) {
                                                  if (newPass == confnewPass) {
                                                    setState(() {
                                                      widget.users.password = newPass;
                                                    });
                                                    updateUserPassword(widget.users.id);
                                                  } else {
                                                    showCoToast();
                                                  }
                                                } else {
                                                  showEToast();
                                                }
                                              }
                                            },
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          );
                        }
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.password),
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Cambiar contraseña")
                              )
                            ),
                            Expanded(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ),
                whiteBox,
                Container(
                  decoration: bdecoration,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Form(
                            key: _formkey_de,
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  Text(
                                    "¿Está seguro que desea eliminar su cuenta? Esta acción no se puede deshacer.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  doublespace,
                                  Text(
                                    "Ingrese la contraseña para confirmar.",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  doublespace,
                                  TextFormField(
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                      setState(() {
                                        confDelete = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Contraseña",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.lock),
                                      )
                                    ),
                                  ),
                                  doublespace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey
                                                  ),
                                            child: Text("CANCELAR")
                                          )
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formkey_de.currentState!.validate()) {
                                                if (confDelete == widget.users.password) {
                                                  deleteUser(widget.users.id);
                                                } else {
                                                  showEToast();
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red
                                                  ),
                                            child: Text("CONFIRMAR"),
                                          )
                                        )
                                      )
                                    ],
                                  ),
                                ],
                              )
                            )
                          );
                        }
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.delete_forever),
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("Eliminar cuenta")
                              )
                            ),
                            Expanded(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
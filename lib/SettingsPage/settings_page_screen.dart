import 'package:flutter/material.dart';
import 'package:proj_ver1/variables.dart';
import 'package:proj_ver1/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/LoginPage/login_page_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/SettingsPage/components/help_page.dart';
import 'package:proj_ver1/SettingsPage/components/terms_page.dart';
import 'package:proj_ver1/SettingsPage/components/privacy_page.dart';
import 'package:proj_ver1/SettingsPage/components/security_page.dart';

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  SettingsPage(this.users, this._ridesU, {Key? key}) : super(key: key);
  final Users users;
  List<Ride> _ridesU = [];

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  checkPermissions() async {
    PermissionStatus resultLoc;
    PermissionStatus resultCam;
    PermissionStatus resultSto;
    resultLoc = await Permission.location.status;
    resultCam = await Permission.camera.status;
    resultSto = await Permission.storage.status;
    if(resultLoc.isGranted) {
      setState(() {
        isSwitchOnLoc = true;
      });
    }
    if(resultCam.isGranted) {
      setState(() {
        isSwitchOnCam = true;
      });
    }
    if(resultSto.isGranted) {
      setState(() {
        isSwitchOnSto = true;
      });
    }
    return ;
  }

  showAbout() {
    return showModalBottomSheet(
      context: context,
      shape: borderRad,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Acerca de UIS Wheels",
                style: TextStyle(fontSize: 20),
              ),
              doublespace,
              Image.asset("assets/images/llanta.png", height: 70),
              doublespace,
              Text("UIS Wheels V1",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)
              )
            ]
          )
        );
      }
    );
  }

  logOut() {
    return showModalBottomSheet(
      context: context,
      shape: borderRad,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "¿Desea cerrar sesión?",
                style: TextStyle(fontSize: 20),
              ),
              doublespace,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: ElevatedButton(
                        child: Text("CANCELAR"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: ElevatedButton(
                        child: Text("CERRAR SESIÓN"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: LoginPage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                      )
                    ),
                  )
                ],
              ),
            ],
          )
        );
      }
    );
  }

  static final bdecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      colors: [Colors.green.withOpacity(0.3), Colors.grey.withOpacity(0.3)],
      end: Alignment.bottomCenter
    ),
    border: Border.all(
      color: Colors.black.withAlpha(130), 
      style: BorderStyle.solid, width: 1
    ),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        blurRadius: 10,
        blurStyle: BlurStyle.outer,
        color: Colors.green.withOpacity(0.1),
        spreadRadius: 2,
      )
    ],
  );

  static final borderRad = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15)
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: bdecoration,
                          height: MediaQuery.of(context).size.height * 0.21,
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              checkPermissions();
                              Navigator.of(context).push(
                                PageTransition(
                                  child: PrivacyPage(widget.users, widget._ridesU),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.privacy_tip, size: 30),
                                space,
                                Text(
                                  "Privacidad",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                      space1,
                      Expanded(
                        child: Container(
                          decoration: bdecoration,
                          height: MediaQuery.of(context).size.height * 0.21,
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: const SecurityPage(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.security, size: 30),
                                space,
                                Text(
                                  "Seguridad",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                  space,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: bdecoration,
                          height: MediaQuery.of(context).size.height * 0.21,
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: const TermsPage(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.document_scanner, size: 30),
                                space,
                                Text(
                                  "Términos y Condiciones",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                  space,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: bdecoration,
                          height: MediaQuery.of(context).size.height * 0.21,
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: const HelpPage(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.help, size: 30),
                                space,
                                Text(
                                  "Ayuda",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                      space1,
                      Expanded(
                        child: Container(
                          decoration: bdecoration,
                          height: MediaQuery.of(context).size.height * 0.21,
                          padding: EdgeInsets.all(15),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info, size: 30),
                                space,
                                Text(
                                  "Acerca de UIS Wheels",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center
                                )
                              ],
                            ),
                            onTap: () {
                              showAbout();
                            },
                          ),
                        )
                      ),
                    ],
                  ),
                  space,
                  Padding(
                    padding: EdgeInsets.only(left: 60, right: 60),
                    child: Container(
                      decoration: bdecoration,
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          logOut();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, size: 30),
                            space1,
                            Text(
                              "Cerrar Sesión",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:proj_ver1/variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/UserPage/user_page_screen.dart';
import 'package:proj_ver1/LoginPage/login_page_screen.dart';
import 'package:proj_ver1/MainPage/components/new_ride.dart';
import 'package:proj_ver1/MainPage/components/ride_page.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/SettingsPage/settings_page_screen.dart';
import 'package:proj_ver1/UserRidesPage/user_rides_page_screen.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.id, required this.users, required this.ridesA, required this.ridesU, required this.ridesP}) : super(key: key);
  final Users users;
  final int id;
  List<Ride> ridesA = [];
  List<Ride> ridesU = [];
  List<Ride> ridesP = [];
  final List<Users> _users = [];

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final TextEditingController _controllerSearchStart = TextEditingController();
  final TextEditingController _controllerSearchEnd = TextEditingController();
  final TextEditingController _controllerSearchDate = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  clearSearch() {
    _controllerSearchStart.clear();
    _controllerSearchEnd.clear();
    _controllerSearchDate.clear();
  }

  loadRides() async {
    widget.ridesA.clear();
    widget.ridesU.clear();
    widget.ridesP.clear();
    final response = await http.get(Uri.parse("http://192.168.1.35:3000/rides"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
        widget.ridesU.addAll(rides.where((element) => widget.id == element.userId));
        widget.ridesP.addAll(rides.where((element) => element.userP1Id == widget.id || element.userP2Id == widget.id || element.userP3Id == widget.id || element.userP4Id == widget.id));
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

  loadFilter() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?start_like=$searchStart&end_like=$searchEnd&dateAndTime_like=$searchDate"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterCloserDate() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?_sort=dateAndTime&_order=asc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterCloserCar() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?vehicle=Autom%C3%B3vil&_sort=dateAndTime&_order=asc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterCloserMoto() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?vehicle=Motocicleta&_sort=dateAndTime&_order=asc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterFurtherDate() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?_sort=dateAndTime&_order=desc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterFurtherCar() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?vehicle=Autom%C3%B3vil&_sort=dateAndTime&_order=desc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  loadFilterFurtherMoto() async {
    widget.ridesA.clear();
    final response =
        await http.get(Uri.parse("http://192.168.1.35:3000/rides?vehicle=Motocicleta&_sort=dateAndTime&_order=desc"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      setState(() {
        widget.ridesA.addAll(rides.where((element) => element.state == false && widget.id != element.userId));
      });
    }
  }

  static final tdecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: const Color.fromARGB(255, 197, 197, 197),
  );

  static final borderdeco = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      style: BorderStyle.solid,
    )
  );

  @override
  Widget build(BuildContext context) {
    Widget noRidesToast() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: tdecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.drive_eta, color: Colors.black87),
          space,
          Text(
            'No se encontraron viajes',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );

    void showRidesToast() => toast.showToast(
      child: noRidesToast(),
      gravity: ToastGravity.CENTER,
    );

    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)
            )
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 32,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.users.icon),
                        radius: 31,
                      ),
                    ),
                    space,
                    Text(
                      widget.users.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    Text(
                      widget.users.email, 
                      style: TextStyle(fontSize: 15)
                    ),
                  ],
                )
              ),
              space,
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text(
                  "Mi Perfil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    PageTransition(
                      child: UserPage(widget.users),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.drive_eta, color: Colors.green),
                title: Text(
                  "Mis Viajes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    PageTransition(
                      child: UserRidesPage(widget.users.id, widget.ridesU, widget.ridesP, widget.users),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                }
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text(
                  "Configuración",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    PageTransition(
                      child: SettingsPage(widget.users, widget.ridesU),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.green),
                title: Text(
                  "Cerrar Sesión",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: LoginPage(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
              )
            ]
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: NewRidePage(users: widget.users),
                type: PageTransitionType.bottomToTop,
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text("Viajes"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Actualizar", style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Text("Fecha más cercana ("),
                        Icon(Icons.drive_eta, color: Colors.black),
                        Text(" y "),
                        Icon(Icons.motorcycle, color: Colors.black),
                        Text(" )")
                      ],
                    )
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        Text("  -  "),
                        Text("Automóvil")
                      ],
                    )
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Row(
                      children: [
                        Text("  -  "),
                        Text("Motocicleta")
                      ],
                    )
                  ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: Row(
                      children: [
                        Text("Fecha más lejana ("),
                        Icon(Icons.drive_eta, color: Colors.black),
                        Text(" y "),
                        Icon(Icons.motorcycle, color: Colors.black),
                        Text(" )")
                      ],
                    )
                  ),
                  PopupMenuItem<int>(
                    value: 5,
                    child: Row(
                      children: [
                        Text("  -  "),
                        Text("Automóvil")
                      ],
                    )
                  ),
                  PopupMenuItem<int>(
                    value: 6,
                    child: Row(
                      children: [
                        Text("  -  "),
                        Text("Motocicleta")
                      ],
                    )
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  loadRides();
                  clearSearch();
                }
                if (value == 1) {
                  loadFilterCloserDate();
                  clearSearch();
                }
                if (value == 2) {
                  loadFilterCloserCar();
                  clearSearch();
                }
                if (value == 3) {
                  loadFilterCloserMoto();
                  clearSearch();
                }
                if (value == 4) {
                  loadFilterFurtherDate();
                  clearSearch();
                }
                if (value == 5) {
                  loadFilterFurtherCar();
                  clearSearch();
                }
                if (value == 6) {
                  loadFilterFurtherMoto();
                  clearSearch();
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: _controllerSearchStart,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(1),
                                enabledBorder: borderdeco,
                                hintText: "Origen",
                                prefixIcon: Icon(Icons.room, color: Colors.black),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: ValidationBuilder(requiredMessage: "Por favor indique el origen").build(),
                              onChanged: (value) {
                                searchStart = _controllerSearchStart.text;
                              },
                            ),
                          )
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: _controllerSearchEnd,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                enabledBorder: borderdeco,
                                hintText: "Destino",
                                prefixIcon: Icon(Icons.room, color: Colors.black),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: ValidationBuilder(requiredMessage: "Por favor indique el destino").build(),
                              onChanged: (value) {
                                searchEnd = _controllerSearchEnd.text;
                              },
                            ),
                          )
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: _controllerSearchDate,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                enabledBorder: borderdeco,
                                hintText: "Fecha y hora",
                                prefixIcon: Icon(Icons.calendar_month, color: Colors.black),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: ValidationBuilder(requiredMessage: "Por favor indique la fecha y/o hora").build(),
                              onChanged: (value) {
                                searchDate = _controllerSearchDate.text;
                              }
                            ),
                          )
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: ElevatedButton(
                              child: Icon(Icons.search),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await loadFilter();
                                  if(widget.ridesA.isEmpty){
                                    showRidesToast();
                                  }
                                  clearSearch();
                                }
                              }
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height *0.6,
                          child: ListView.builder(
                            itemCount: widget.ridesA.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey.shade100,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: (() {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: RidePage(ride: widget.ridesA[index], id: widget.ridesA[index].id, users: widget.users, usersL: widget._users),
                                          type: PageTransitionType.rightToLeft,
                                        ),
                                      );
                                    }),
                                    child: SizedBox(
                                      height: 140,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            widget.ridesA[index].vehicle == 'Motocicleta' ? Icons.motorcycle : Icons.drive_eta, 
                                            size: 25
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Origen: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold)
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  widget.ridesA[index].start,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Destino: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold)
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  widget.ridesA[index].end,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )
                                              ),
                                            ],
                                          ),
                                          space,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(widget.ridesA[index].dateAndTime)
                                            ],
                                          ),
                                          Icon(
                                            widget.ridesA[index].stateR == true ? Icons.play_arrow : null,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ), 
      onWillPop: () async {
        return false;
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:proj_ver1/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayuda"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(40),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "Publicar, editar y eliminar viajes",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                          ),
                          doublespace,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          doublespace,
                          Text(
                            "Publicar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          doublespace,
                          Text(
                            "Editar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          doublespace,
                          Text(
                            "Eliminar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.drive_eta),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Publicar, editar y eliminar viajes", style: TextStyle(fontSize:17)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_right)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(40),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "Buscar y formar parte de un viaje",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                          ),
                          doublespace,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis. Suspendisse maximus diam ante, vitae aliquam enim sodales a. Curabitur mauris erat, sodales eget felis a, accumsan lobortis leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec nec mauris blandit, cursus lacus ut, dictum mi. Sed eu enim eget erat convallis elementum eu et erat. Aliquam et viverra elit, nec semper arcu.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.drive_eta),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Buscar y formar parte de un viaje", style: TextStyle(fontSize:17)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(40),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "Editar perfil",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                          ),
                          doublespace,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis. Suspendisse maximus diam ante, vitae aliquam enim sodales a. Curabitur mauris erat, sodales eget felis a, accumsan lobortis leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec nec mauris blandit, cursus lacus ut, dictum mi. Sed eu enim eget erat convallis elementum eu et erat. Aliquam et viverra elit, nec semper arcu.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.edit),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Editar perfil", style: TextStyle(fontSize:17)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) {
                    return Padding(
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis. Suspendisse maximus diam ante, vitae aliquam enim sodales a. Curabitur mauris erat, sodales eget felis a, accumsan lobortis leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec nec mauris blandit, cursus lacus ut, dictum mi. Sed eu enim eget erat convallis elementum eu et erat. Aliquam et viverra elit, nec semper arcu.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.password),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Cambiar contraseña", style: TextStyle(fontSize:17)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_right)
                        ),
                      ), 
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: InkWell(
              onTap: () {
                showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(40),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "Eliminar cuenta",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                          ),
                          doublespace,
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sit amet sapien felis. Proin auctor sit amet mauris ac faucibus. Morbi fermentum est quis augue facilisis convallis. Suspendisse maximus diam ante, vitae aliquam enim sodales a. Curabitur mauris erat, sodales eget felis a, accumsan lobortis leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec nec mauris blandit, cursus lacus ut, dictum mi. Sed eu enim eget erat convallis elementum eu et erat. Aliquam et viverra elit, nec semper arcu.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.delete),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Eliminar cuenta", style: TextStyle(fontSize:17)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}

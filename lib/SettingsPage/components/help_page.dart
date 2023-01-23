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
                            "Publicar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "En la pantalla principal, seleccionar el botón circular ubicado en la esquina inferior derecha. Esto mostrará un pantalla con un formulario como el que se muestra a continuación:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/form_new_ride.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Para seleccionar el punto de origen y destino, se requiere seleccionar el botón ubicado al lado de cada campo. Esto mostrará una pantalla como la que se muestra a continuación:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/add_point.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Al seleccionar un punto en el mapa aparecerá un marcador y un campo de texto mostrando la dirección correspondiente. Puede eliminar el marcador cuantas veces deseé hasta encontrar la dirección deseada.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/add_point_marker.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Después de seleccionar los puntos de origen y destino en el mapa, estos aparecerán en los campos de texto correspondientes en el formulario, por lo que solo queda diligenciar el resto de campos y oprimir el check para guardar el viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/form_new_ride_complete.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Si el viaje se guardó correctamente, se mostrará lo siguiente:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/new_ride_yes.png",
                            height: 100,
                          ),
                          space,
                          Text(
                            "Y se podrá encontrar en la siguiente pantalla: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/verify_add.png",
                            height: 260,
                          ),
                          Text(
                            "Nota: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "Para llegar a esta pantalla, se debe abrir el menú ubicado en la parte izquierda de la pantalla principal y seleccionar 'Mis Viajes'.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13),
                          ),
                          doublespace,
                          Text(
                            "Editar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "En la pantalla 'Mis Viajes' puede encontrar la lista de viajes que ha creado y editarlos seleccionando el botón con forma de lápiz que se encuentra en la parte de abajo de cada viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/edit_ride.png",
                            height: 150,
                          ),
                          space,
                          Text(
                            "Si el viaje no se encuentra en progreso o finalizado, se abrirá un formulario idéntico al que diligenció al crear el viaje, en el que podrá cambiar cualquiera de los datos que anteriormente había guardado, y guardarlos seleccionando el check.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/edit_ride_form.png",
                            height: 260,
                          ),
                          Text(
                            "Nota: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "Los puntos de origen y destino se pueden editar siguiendo los mismos pasos mencionados en la creación del viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13),
                          ),
                          doublespace,
                          Text(
                            "Eliminar viajes",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          space,
                          Text(
                            "En la pantalla 'Mis Viajes' puede encontrar la lista de viajes que ha creado y eliminarlos seleccionando el botón con forma de caneca que se encuentra en la parte de abajo de cada viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/delete_ride.png",
                            height: 150,
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
                            "En la pantalla principal se encuentra la lista de todos los viajes publicados, los cuales pueden ser filtrados por origen, destino y fecha y hora, como se muestra a continuación: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/search.png",
                            height: 125,
                          ),
                          Text(
                            "Parámetros de la búsqueda",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                          doublespace,
                          doublespace,
                          Image.asset(
                            "assets/images/result.png",
                            height: 260,
                          ),
                          Text(
                            "Resultado de la búsqueda",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                          space,
                          Text(
                            "Del mismo modo, se puede recargar la lista completa de viajes o filtrarla, escogiendo alguna de las opciones del menú flotante ubicado en la esquina superior derecha.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/pop_up.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Para formar parte de un viaje, se debe seleccionar uno de los viajes de la lista. Esto mostrará una página con los respectivos detalles del viaje y un botón con el signo + en la esquina superior derecha, el cual al presionarlo lo añadirá como pasajero de ese viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/ride_page.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Si fue agregado exitosamente, se mostrará lo siguiente: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/ride_page_su.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Y se mostrará en la siguiente pantalla: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/verify_add_pa.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Al seleccionar el viaje, se mostrará una pantalla mostrando sus detalles y, en la parte superior derecha un botón para acceder a un chat con el conductor del viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/ride_page_me.png",
                                height: 210,
                              ),
                              space1,
                              Image.asset(
                                "assets/images/chat.png",
                                height: 210,
                              ),
                            ],
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
                          child: Icon(Icons.people),
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
                            "Formar parte de un viaje como conductor",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                          ),
                          doublespace,
                          Text(
                            "En la pantalla 'Mis Viajes' se encuentra la lista de los viajes que ha creado. Al seleccionar un viaje, se mostrará una pantalla con sus detalles y, en la parte superior derecha un botón para acceder a la lista de pasajeros que actualmente hacen parte del viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/ride_page_co.png",
                                height: 210,
                              ),
                              space1,
                              Image.asset(
                                "assets/images/pass_list.png",
                                height: 210,
                              ),
                            ],
                          ),
                          Text(
                            "Nota: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "Para cada pasajero, se puede visualizar su información, abrir el chat y eliminar del viaje.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13),
                          ),
                          space,
                          Text(
                            "Del mismo modo, el conductor puede indicar que inició o finalizó el viaje, seleccionando el botón que se encuentra al lado del botón de pasajeros.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/ride_page_co_i.png",
                                height: 210,
                              ),
                              space1,
                              Image.asset(
                                "assets/images/ride_page_co_f.png",
                                height: 210,
                              ),
                            ],
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
                          child: Text("Formar parte de un viaje como conductor", style: TextStyle(fontSize:17)),
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
                            "Para editar datos personales como el nombre, fecha de nacimiento y correo, se debe abrir el menú ubicado en la parte izquierda de la página principal y seleccionar 'Mi Perfil'. Esto mostrará la siguiente pantalla, en la que podrá hacer los cambios respectivos: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/profile.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Nota: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "Los datos se guardan automáticamente en la base de datos, por lo que no es necesario hacer ninguna confirmación al cambiar estos datos.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13),
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
                            "Para cambiar la contraseña se debe abrir el menú ubicado en la parte izquierda de la página principal y seleccionar 'Configuración'. Esto mostrará la siguiente pantalla: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/settings.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Se debe seleccionar el recuadro llamado 'Privacidad', el cual mostrará la siguiente pantalla, en la cual se debe seleccionar la opción 'Cambiar contraseña': ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/privacy.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Esto mostrará la siguiente pantalla, en la cual deberá diligenciar los datos que se le piden: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/change_pass.png",
                            height: 260,
                          ),
                          space,
                          Text(
                            "Finalmente, si los datos son correctos, se mostrará lo siguiente: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/pass.png",
                            height: 100,
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
                            "Para eliminar definitivamente la cuenta, se deben seguir los pasos mencionados en el apartado 'Cambiar contraseña', con la diferencia de que se debe seleccionar 'Eliminar cuenta' y proporcionar la contraseña actual en la siguiente pantalla: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          space,
                          Image.asset(
                            "assets/images/delete.png",
                            height: 260,
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
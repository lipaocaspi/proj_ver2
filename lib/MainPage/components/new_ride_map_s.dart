import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:proj_ver1/variables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';

// ignore: must_be_immutable
class NewRideMapS extends StatefulWidget {
  NewRideMapS({Key? key, required this.value, required this.users}) : super(key: key);
  Position value;
  final Users users;

  @override
  State<NewRideMapS> createState() => NewRideMapSState();
}

class NewRideMapSState extends State<NewRideMapS> {
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  bool isMarker = false;
  TextEditingController _controller = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  _handleTap(LatLng tappedPoint) async {
    MarkerId markerId = MarkerId(tappedPoint.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: tappedPoint,
      draggable: true
    );
    setState(() {
      if(markers.isEmpty) {
        markers[MarkerId(tappedPoint.toString())] = marker;
        isMarker = true;
      }
    });
    var placemarks = await placemarkFromCoordinates(tappedPoint.latitude, tappedPoint.longitude);
    var first = placemarks.first;
    setState(() {
      start = "${first.street}, ${first.subLocality}, ${first.locality}";
      latS = tappedPoint.latitude.toString();
      lonS = tappedPoint.longitude.toString();
    });
    selectedMarker = markerId;
  }

  void _removeMarker(MarkerId markerId) {
    setState(() {
      if(markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MarkerId? selectedId = selectedMarker;
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.map),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              start = "";
              latS = "";
              lonS = "";
            });
            Navigator.pop(context); 
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Text(
                "Seleccione el punto de origen en el mapa",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)
              )
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  markers: Set<Marker>.of(markers.values),
                  onTap: _handleTap,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.value.latitude, widget.value.longitude),
                    zoom: 15,
                  )
                )
              )
            ),
            Visibility(
              child: TextFormField(
                enabled: false,
                controller: _controller..text = start,
              ),
              visible: isMarker,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text("Eliminar marcador"),
                    onPressed: () {
                      _removeMarker(selectedId!);
                      setState(() {
                        isMarker = false;
                        start = "";
                        latS = "";
                        lonS = "";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text("Guardar ubicación"),
                    onPressed: () {
                      if(markers.isEmpty) {
                        final errorSnack = SnackBar(
                          content: Text("Seleccione una ubicación"),
                          action: SnackBarAction(
                            label: "Cerrar",
                            onPressed: () {
                              Navigator.of(context);
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(errorSnack);
                      } else {
                        String start = _controller.text;
                        Navigator.pop(context, start);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
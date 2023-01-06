import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/data/repository/models/ride_model.dart';

abstract class RideRepository {
  Future<List<Ride>> getRide();
}

class RideRepositoryImpl implements RideRepository {
  @override
  Future<List<Ride>> getRide() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.39:3000/rides"));

    if (response.statusCode == 200) {
      List<dynamic> myRides = json.decode(utf8.decode(response.bodyBytes));
      List<Ride> rides = myRides.map((e) => Ride.fromJson(e)).toList();
      print(rides);

      return rides;
    } else {
      throw Exception('No se pudo recuperar el repositorio');
    }
  }
}

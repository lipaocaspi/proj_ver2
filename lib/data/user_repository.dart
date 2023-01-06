import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/data/repository/models/user_model.dart';

abstract class UsersRepository {
  Future<List<Users>> getUser();
}

class UsersRepositoryImpl implements UsersRepository {
  @override
  Future<List<Users>> getUser() async {
    final response = await http.get(Uri.parse("http://192.168.1.39:3000/users"));

    if (response.statusCode == 200) {
      List<dynamic> myUsers = json.decode(response.body);
      List<Users> users = myUsers.map((e) => Users.fromJson(e)).toList();
      if (users.isEmpty) {
        print("Las credenciales son incorrectas");
      } else {
        print(response.body);
      }
      return users;
    } else {
      throw Exception('No se pudo encontrar el usuario');
    }
  }
}

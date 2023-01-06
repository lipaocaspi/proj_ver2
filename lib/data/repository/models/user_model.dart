import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.icon,
    required this.password,
  });

  int id;
  String name;
  String email;
  String dateOfBirth;
  String icon;
  String password;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        dateOfBirth: json["dateOfBirth"],
        icon: json["icon"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "icon": icon,
        "password": password,
      };
}

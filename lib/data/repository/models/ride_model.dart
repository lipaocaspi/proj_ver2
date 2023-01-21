import 'dart:convert';

List<Ride> rideFromJson(String str) =>
    List<Ride>.from(json.decode(str).map((x) => Ride.fromJson(x)));

String rideToJson(List<Ride> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ride {
  Ride({
    required this.userId,
    required this.userP1Id,
    required this.userP2Id,
    required this.userP3Id,
    required this.userP4Id,
    required this.id,
    required this.start,
    required this.latS,
    required this.lonS,
    required this.end,
    required this.latE,
    required this.lonE,
    required this.dateAndTime,
    required this.vehicle,
    required this.room,
    required this.color,
    required this.plate,
    required this.price,
    required this.state,
    required this.stateR,
  });

  int userId;
  int userP1Id;
  int userP2Id;
  int userP3Id;
  int userP4Id;
  int id;
  String start;
  String latS;
  String lonS;
  String end;
  String latE;
  String lonE;
  String dateAndTime;
  String vehicle;
  String room;
  String color;
  String plate;
  String price;
  bool state;
  bool stateR;

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        userId: json["userId"],
        userP1Id: json["userP1Id"],
        userP2Id: json["userP2Id"],
        userP3Id: json["userP3Id"],
        userP4Id: json["userP4Id"],
        id: json["id"],
        start: json["start"],
        latS: json["latS"],
        lonS: json["lonS"],
        end: json["end"],
        latE: json["latE"],
        lonE: json["lonE"],
        dateAndTime: json["dateAndTime"],
        vehicle: json["vehicle"],
        room: json["room"],
        color: json["color"],
        plate: json["plate"],
        price: json["price"],
        state: json["state"],
        stateR: json["stateR"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userP1Id": userP1Id,
        "userP2Id": userP2Id,
        "userP3Id": userP3Id,
        "userP4Id": userP4Id,
        "id": id,
        "start": start,
        "latS": latS,
        "lonS": lonS,
        "end": end,
        "latE": latE,
        "lonE": lonE,
        "dateAndTime": dateAndTime,
        "vehicle": vehicle,
        "room": room,
        "color": color,
        "plate": plate,
        "price": price,
        "state": state,
        "stateR": stateR,
      };
}
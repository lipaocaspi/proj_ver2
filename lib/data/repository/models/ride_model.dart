import 'dart:convert';

List<Ride> rideFromJson(String str) =>
    List<Ride>.from(json.decode(str).map((x) => Ride.fromJson(x)));

String rideToJson(List<Ride> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ride {
  Ride({
    required this.userId,
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
  });

  int userId;
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

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        userId: json["userId"],
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
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
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
      };
}

// class Start {
//   Start({
//     required this.name,
//     required this.geo,
//   });

//   String name;
//   Geo geo;

//   factory Start.fromJson(Map<String, dynamic> json) =>
//   Start(
//     name: json["name"],
//     geo: Geo.fromJson(json["geo"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "geo": geo.toJson(),
//   };
// }

// class End {
//   End({
//     required this.name,
//     required this.geo,
//   });

//   String name;
//   Geo geo;

//   factory End.fromJson(Map<String, dynamic> json) =>
//   End(
//     name: json["name"],
//     geo: Geo.fromJson(json["geo"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "geo": geo.toJson(),
//   };
// }

// class Geo {
//   Geo({
//     required this.lat,
//     required this.lon,
//   });

//   String lat;
//   String lon;

//   factory Geo.fromJson(Map<String, dynamic> json) => Geo(
//     lat: json["lat"],
//     lon: json["lon"],
//   );

//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lon": lon,
//   };
// }
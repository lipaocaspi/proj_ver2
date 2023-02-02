import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.id,
    required this.rideId,
    required this.userIdOne,
    required this.userIdTwo,
    required this.text,
    required this.idSent,
  });

  int id;
  int rideId;
  int userIdOne;
  int userIdTwo;
  String text;
  int idSent;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        rideId: json["rideId"],
        userIdOne: json["userIdOne"],
        userIdTwo: json["userIdTwo"],
        text: json["text"],
        idSent: json["idSent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rideId": rideId,
        "userIdOne": userIdOne,
        "userIdTwo": userIdTwo,
        "text": text,
        "idSent": idSent,
      };
}
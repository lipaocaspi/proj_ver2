import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj_ver1/constants.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/data/repository/models/messages_model.dart';

// ignore: must_be_immutable
class MessagePageC extends StatefulWidget {
  MessagePageC({Key? key, required this.idU, required this.id, required this.users, required this.message, required this.message_count}) : super(key: key);
  int idU;
  int id;
  final Users users;
  List <Message> message = [];
  List <Message> message_count = [];

  @override
  State<MessagePageC> createState() => MessagePageStateC();
}

class MessagePageStateC extends State<MessagePageC> {
  final TextEditingController _controllerMessage = TextEditingController();
  late Message newMessage;

  sendMessage() async {
    if(_controllerMessage.text.isEmpty) {
      final noSentSnack = SnackBar(
        content: Text("Por favor escriba un mensaje"),
        action: SnackBarAction(
          label: "Cerrar",
          onPressed: () {
            Navigator.of(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(noSentSnack);
    }
    else {
      newMessage = Message(
        id: widget.message_count.length + 1,
        userIdOne: widget.id,
        userIdTwo: widget.idU,
        text: _controllerMessage.text,
        idSent: widget.idU
      );
      final res = await http.post(Uri.parse("http://192.168.1.35:3000/messages"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "id": newMessage.id,
          "userIdOne": newMessage.userIdOne,
          "userIdTwo": newMessage.userIdTwo,
          "text": newMessage.text,
          "idSent": newMessage.idSent,
        })
      );
      if(res.statusCode == 201) {
        _controllerMessage.clear();
        widget.message.clear();
        widget.message_count.clear();
        final response = await http.get(Uri.parse("http://192.168.1.35:3000/messages"));

        if (response.statusCode == 200) {
          List<dynamic> myMessages = json.decode(utf8.decode(response.bodyBytes));
          List<Message> messages = myMessages.map((e) => Message.fromJson(e)).toList();
          setState(() {
            widget.message_count.addAll(messages);
            widget.message.addAll(messages.where((element) => element.userIdOne == widget.id || element.userIdTwo == widget.id));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.users.name),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: widget.message.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 14, right: 14, top: 2, bottom: 2),
                child: Align(
                  alignment: (widget.message[index].idSent == widget.users.id ? Alignment.topLeft : Alignment.topRight),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (widget.message[index].idSent  == widget.users.id ? Colors.grey.shade200 : Colors.green[200]),
                    ),
                    child: Text(widget.message[index].text),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _controllerMessage,
                      decoration: InputDecoration(
                        hintText: "Escriba su mensaje",
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  space1,
                  FloatingActionButton.small(
                    child: Icon(Icons.send,color: Colors.white,size: 18),
                    backgroundColor: Colors.green,
                    elevation: 0,
                    onPressed: (){
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
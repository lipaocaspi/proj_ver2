import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/ImboxPage/components/selected_message.dart';

class ImboxPage extends StatelessWidget {
  const ImboxPage({Key? key}) : super(key: key);
  static final bdecoration = BoxDecoration(
    color: Colors.grey.withOpacity(0.3),
  );

  static final whiteBox = SizedBox(height: 5, child: Container(color: Colors.white));
  static final greyBox = SizedBox(height: 1, child: Container(color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensajes"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: ListView(
              children: [
                Container(
                  decoration: bdecoration,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const MessagePage(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1661544641467-d1811f77c71e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=650&q=80'),
                                ),
                              )
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("NOMBRE")
                              )
                            ),
                            Expanded(child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ],
                    ),
                  )
                ),
                whiteBox,
                Container(
                  decoration: bdecoration,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const MessagePage(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1661544641467-d1811f77c71e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=650&q=80'),
                                ),
                              )
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("NOMBRE")
                              )
                            ),
                            Expanded(child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seguridad"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("PIN de Seguridad"),
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
        ]
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.bottomImage = "assets/images/logo_UIS.png",
  }) : super(key: key);

  final String bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 150, 255, 141),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 20,
              right: 20,
              child: Image.asset(
                bottomImage,
                width: 90,
              ),
            ),
            const Positioned(bottom: 20, left: 20, child: Text("© Derechos")),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

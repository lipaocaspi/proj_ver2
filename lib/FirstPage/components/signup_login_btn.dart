import 'package:flutter/material.dart';
import 'package:proj_ver1/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proj_ver1/LoginPage/login_page_screen.dart';
import 'package:proj_ver1/SignupPage/signup_page_screen.dart';

class LoginSignUpBtn extends StatelessWidget {
  const LoginSignUpBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: const LoginPage(),
                type: PageTransitionType.fade,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kButtonPrimaryColor,
            fixedSize: const Size(250, 50)
          ),
          child: const Text(
            "INGRESAR",
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: const SignUpPage(),
                type: PageTransitionType.fade,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kButtonPrimaryLightColor,
            fixedSize: const Size(250, 50)
          ),
          child: const Text(
            "REGISTRARSE",
            style: TextStyle(color: kButtonPrimaryColor)
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proj_ver1/components/background.dart';
import 'package:proj_ver1/FirstPage/components/image.dart';
import 'package:proj_ver1/FirstPage/components/signup_login_btn.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Imag(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 6,
                child: LoginSignUpBtn(),
              ),
              Spacer(),
            ],
          ),
        ],
      )
    ); 
  }
}

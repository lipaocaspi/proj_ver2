import 'package:flutter/material.dart';
import 'package:proj_ver1/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_ver1/FirstPage/first_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UIS Wheels',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: kPrimaryColor,
          foregroundColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kButtonPrimaryColor,
            elevation: 4,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 253, 255, 253),
          iconColor: Colors.white,
          prefixIconColor: Color.fromARGB(255, 131, 131, 131).withOpacity(0.8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(style: BorderStyle.solid, color: Colors.black)
          )
        ),
        primaryColor: Colors.green.withOpacity(0.8),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 254, 254),
        textTheme: GoogleFonts.latoTextTheme(),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      ),
      home: FirstPage(),
    );
  }
}

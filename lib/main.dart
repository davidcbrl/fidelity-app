import 'package:fidelity/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Fidelity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF828282),
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(
            color: Color(0xFF2167E8),
            fontSize: 14
          )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF2167E8),
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: LoginScreen(),
    );
  }
}


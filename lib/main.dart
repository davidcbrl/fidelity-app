import 'package:fidelity/pages/auth/login_page.dart';
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
        primaryColor: Color(0xFF2167E8),
        backgroundColor: Color(0xFFF7F7F7),
        accentColor: Color(0xFFFFFFFF),
        textTheme: TextTheme(
          headline1: TextStyle(color: Color(0xFF2167E8), fontSize: 20, fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Color(0xFF2167E8), fontSize: 14, fontWeight: FontWeight.normal),
          bodyText1: TextStyle(color: Color(0xFF828282), fontSize: 14, fontWeight: FontWeight.normal),
          bodyText2: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14, fontWeight: FontWeight.normal),
          button: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      home: LoginPage(),
    );
  }
}

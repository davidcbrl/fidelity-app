import 'package:fidelity/pages/auth/login.dart';
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
        colorScheme: ColorScheme(
          primary: Color(0xFF2167E8),
          onPrimary: Color(0xFF2167E8),
          primaryVariant: Color(0xFF2167E8),
          secondary: Color(0xFF23D09A),
          onSecondary: Color(0xFF23D09A),
          secondaryVariant: Color(0xFF23D09A),
          error: Color(0xFFEB5757),
          onError: Color(0xFFEB5757),
          background: Color(0xFFF7F7F7),
          onBackground: Color(0xFFF7F7F7),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xFF2167E8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Color(0xFF2167E8),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          bodyText1: TextStyle(
            color: Color(0xFF828282),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          button: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

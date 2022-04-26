import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fidelity',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Color(0xFF2167E8),
          onPrimary: Color(0xFF2167E8),
          secondary: Color(0xFF23D09A),
          onSecondary: Color(0xFF23D09A),
          tertiary: Color(0xFF828282),
          onTertiary: Color(0xFF828282),
          tertiaryContainer: Color(0xFFBDBDBD),
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
      initialRoute: box.read('jwt') != null ? '/home' : '/auth',
      initialBinding: BindingsBuilder(() => Get.put<RouteController>(new RouteController())),
      getPages: getRoutes(),
    );
  }
}

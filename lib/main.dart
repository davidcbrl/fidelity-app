import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await GetStorage.init();
  await oneSignalSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fidelify',
      theme: ThemeData(
        fontFamily: 'Manrope',
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
          background: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFF5F5F5),
          onSurface: Color(0xFFF5F5F5),
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
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF828282),
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

Future<void> oneSignalSetup() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('f5fb5ded-0185-4984-8024-53f233218894');
}

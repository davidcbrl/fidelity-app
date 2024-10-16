import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('f5fb5ded-0185-4984-8024-53f233218894');
  await OneSignal.Notifications.requestPermission(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () => FlutterNativeSplash.remove());
    return GetMaterialApp(
      title: 'Fidelify',
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2167E8),
          primaryContainer: Color(0xFF2167E8),
          secondary: Color(0xFF23D09A),
          secondaryContainer: Color(0xFF23D09A),
          tertiary: Color(0xFF828282),
          tertiaryContainer: Color(0xFFBDBDBD),
          surface: Color(0xFFFFFFFF),
          error: Color(0xFFEB5757),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF2167E8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Color(0xFF2167E8),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            color: Color(0xFF828282),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF828282),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          displayMedium: TextStyle(
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

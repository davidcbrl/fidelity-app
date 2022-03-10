import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/pages/auth/login.dart';
import 'package:fidelity/pages/customer/customer_signup.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/pages/products/product_add_page.dart';
import 'package:fidelity/pages/products/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
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
          primaryVariant: Color(0xFF2167E8),
          secondary: Color(0xFF23D09A),
          onSecondary: Color(0xFF23D09A),
          secondaryVariant: Color(0xFF828282),
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
      getPages: [
        GetPage(
          name: '/auth',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: BindingsBuilder(() =>
              Get.put<PageController>(new PageController(initialPage: Get.find<RouteController>().pageIndex.value))),
        ),
        GetPage(
          name: "/product",
          page: () => ProductListPage(),
          binding: BindingsBuilder(() => Get.put<ProductController>(new ProductController())),
          children: [
            GetPage(name: "/add", page: () => ProductAddPage()),
          ],
        ),
        GetPage(
          name: "/fidelity",
          page: () => FidelityListPage(),
          binding: BindingsBuilder(() => Get.put<FidelityController>(new FidelityController())),
          children: [
            GetPage(name: "/add", page: () => ProductAddPage()),
          ],
        ),
        GetPage(
          name: "/customer/signup",
          page: () => CustomerSignupPage(),
          binding: BindingsBuilder(() => Get.put(new CustomerController())),
        ),
      ],
    );
  }
}

import 'package:fidelity/pages/fidelities/fidelity_condition_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';
import '../controllers/fidelity_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/route_controller.dart';
import '../pages/auth/login.dart';
import '../pages/customer/customer_signup.dart';
import '../pages/fidelities/fidelity_add.dart';
import '../pages/fidelities/fidelity_list_page.dart';
import '../pages/home/home.dart';
import '../pages/products/product_add_page.dart';
import '../pages/products/product_list_page.dart';

final routes = [
  GetPage(
    name: '/auth',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    binding: BindingsBuilder(
        () => Get.put<PageController>(new PageController(initialPage: Get.find<RouteController>().pageIndex.value))),
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
      GetPage(name: "/add", page: () => FidelityAddPage(), transition: Transition.cupertino),
      GetPage(name: "/condition", page: () => FidelityConditionTypePage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: "/customer/signup",
    page: () => CustomerSignupPage(),
    binding: BindingsBuilder(() => Get.put(new CustomerController())),
  ),
];

getRoutes() {
  return List.of(routes);
}

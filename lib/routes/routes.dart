import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:fidelity/pages/auth/login.dart';
import 'package:fidelity/pages/signup/first_step.dart';
import 'package:fidelity/pages/signup/second_step.dart';
import 'package:fidelity/pages/signup/third_step.dart';
import 'package:fidelity/pages/signup/sign_up_success.dart';
import 'package:fidelity/pages/customer/customer_signup.dart';
import 'package:fidelity/pages/customer/customer_success.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/pages/products/product_list_page.dart';
import 'package:fidelity/pages/products/product_add_page.dart';
import 'package:fidelity/pages/products/product_fidelities_page.dart';
import 'package:fidelity/pages/products/product_success_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_add.dart';
import 'package:fidelity/pages/fidelities/fidelity_condition_type.dart';
import 'package:fidelity/pages/fidelities/fidelity_condition.dart';
import 'package:fidelity/pages/fidelities/fidelity_promotion_type_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_promotion_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_products_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_success_page.dart';
import 'package:fidelity/pages/settings/settings_page.dart';
import 'package:fidelity/pages/code/code_page.dart';

import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';

final routes = [
  GetPage(
    name: '/auth',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/signup/company',
    page: () => FirstStepPage(),
    children: [
      GetPage(name: '/first_step', page: () => FirstStepPage()),
      GetPage(name: '/second_step', page: () => SecondStepPage()),
      GetPage(name: '/third_step', page: () => ThirdStepPage()),
      GetPage(name: '/success', page: () => SignUpSuccessPage()),
    ]
  ),
  GetPage(
    name: '/signup/customer',
    page: () => CustomerSignupPage(),
    binding: BindingsBuilder(() => Get.put(new CustomerController())),
    children: [
      GetPage(name: '/success', page: () => CustomerSuccessPage()),
    ],
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    binding: BindingsBuilder(() => Get.put<PageController>(new PageController(initialPage: Get.find<RouteController>().pageIndex.value))),
  ),
  GetPage(
    name: '/product',
    page: () => ProductListPage(),
    binding: BindingsBuilder(() => Get.put<ProductController>(new ProductController())),
    children: [
      GetPage(name: '/add', page: () => ProductAddPage()),
      GetPage(name: '/fidelities', page: () => ProductFidelitiesPage()),
      GetPage(name: '/success', page: () => ProductSuccessPage()),
    ],
  ),
  GetPage(
    name: '/fidelity',
    page: () => FidelityListPage(),
    binding: BindingsBuilder(() => Get.put<FidelityController>(new FidelityController())),
    children: [
      GetPage(name: '/add', page: () => FidelityAddPage(), transition: Transition.cupertino),
      GetPage(name: '/condition_type', page: () => FidelityConditionTypePage(), transition: Transition.cupertino),
      GetPage(name: '/condition', page: () => FidelityConditionPage(), transition: Transition.cupertino),
      GetPage(name: '/promotion_type', page: () => FidelityPromotionTypePage(), transition: Transition.cupertino),
      GetPage(name: '/promotion', page: () => FidelityPromotionPage(), transition: Transition.cupertino),
      GetPage(name: '/products', page: () => FidelityProductsPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => FidelitySuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/code',
    page: () => CodePage(),
  ),
  GetPage(
    name: '/settings',
    page: () => SettingsPage(),
  ),
];

getRoutes() {
  return List.of(routes);
}

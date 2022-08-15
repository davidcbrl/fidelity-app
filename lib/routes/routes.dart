import 'package:fidelity/controllers/category_controller.dart';
import 'package:fidelity/controllers/checkpoint_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/employee_controller.dart';
import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/pages/auth/login_page.dart';
import 'package:fidelity/pages/auth/password_reset_page.dart';
import 'package:fidelity/pages/auth/reset_success_page.dart';
import 'package:fidelity/pages/categories/category_add_page.dart';
import 'package:fidelity/pages/categories/category_list_page.dart';
import 'package:fidelity/pages/categories/category_success_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_completed_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_progress_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_scanner_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_success_page.dart';
import 'package:fidelity/pages/customer/customer_fidelities_page.dart';
import 'package:fidelity/pages/customer/customer_profile_page.dart';
import 'package:fidelity/pages/customer/customer_sign_up_success.dart';
import 'package:fidelity/pages/customer/customer_signup_page.dart';
import 'package:fidelity/pages/customer/customer_success_page.dart';
import 'package:fidelity/pages/employees/employee_add_page.dart';
import 'package:fidelity/pages/employees/employee_list_page.dart';
import 'package:fidelity/pages/employees/employee_success_page.dart';
import 'package:fidelity/pages/enterprises/enterprise_list_page.dart';
import 'package:fidelity/pages/enterprises/enterprise_promotions_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_add.dart';
import 'package:fidelity/pages/fidelities/fidelity_condition.dart';
import 'package:fidelity/pages/fidelities/fidelity_condition_type.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_products_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_products_page_cashout.dart';
import 'package:fidelity/pages/fidelities/fidelity_promotion_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_promotion_type_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_success_page.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/pages/products/product_add_page.dart';
import 'package:fidelity/pages/products/product_fidelities_page.dart';
import 'package:fidelity/pages/products/product_list_page.dart';
import 'package:fidelity/pages/products/product_success_page.dart';
import 'package:fidelity/pages/settings/about_page.dart';
import 'package:fidelity/pages/settings/enterprise_profile_page.dart';
import 'package:fidelity/pages/settings/enterprise_success_page.dart';
import 'package:fidelity/pages/settings/settings_page.dart';
import 'package:fidelity/pages/signup/first_step.dart';
import 'package:fidelity/pages/signup/second_step.dart';
import 'package:fidelity/pages/signup/sign_up_success.dart';
import 'package:fidelity/pages/signup/third_step.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(
    name: '/auth',
    page: () => LoginPage(),
    children: [
      GetPage(name: '/password_reset', page: () => PasswordResetPage(), transition: Transition.cupertino),
      GetPage(name: '/reset_success', page: () => ResetSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/signup/enterprise',
    page: () => FirstStepPage(),
    children: [
      GetPage(name: '/first_step', page: () => FirstStepPage(), transition: Transition.cupertino),
      GetPage(name: '/second_step', page: () => SecondStepPage(), transition: Transition.cupertino),
      GetPage(name: '/third_step', page: () => ThirdStepPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => SignUpSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/signup/customer',
    page: () => CustomerSignupPage(),
    binding: BindingsBuilder(() => Get.put(new CustomerController())),
    children: [
      GetPage(name: '/success', page: () => CustomerSignUpSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    binding: BindingsBuilder(
        () => Get.put<PageController>(new PageController(initialPage: Get.find<RouteController>().pageIndex.value))),
  ),
  GetPage(
    name: '/product',
    page: () => ProductListPage(),
    binding: BindingsBuilder(() => Get.put<ProductController>(new ProductController())),
    children: [
      GetPage(name: '/add', page: () => ProductAddPage(), transition: Transition.cupertino),
      GetPage(name: '/fidelities', page: () => ProductFidelitiesPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => ProductSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/fidelity',
    page: () => FidelityListPage(),
    binding: BindingsBuilder(() => Get.put<FidelityController>(new FidelityController())),
    children: [
      GetPage(name: '/add', page: () => FidelityAddPage(Get.arguments), transition: Transition.cupertino),
      GetPage(name: '/condition_type', page: () => FidelityConditionTypePage(), transition: Transition.cupertino),
      GetPage(name: '/condition', page: () => FidelityConditionPage(), transition: Transition.cupertino),
      GetPage(name: '/promotion_type', page: () => FidelityPromotionTypePage(), transition: Transition.cupertino),
      GetPage(name: '/promotion', page: () => FidelityPromotionPage(), transition: Transition.cupertino),
      GetPage(name: '/products', page: () => FidelityProductsPage(), transition: Transition.cupertino),
      GetPage(name: '/cashout', page: () => FidelityProductsPageCashout(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => FidelitySuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/checkpoint',
    page: () => CheckpointPage(),
    binding: BindingsBuilder(() => Get.put(() => CheckpointController())),
    children: [
      GetPage(name: '/scan', page: () => CheckpointScannerPage(), transition: Transition.cupertino),
      GetPage(name: '/customer_fidelities', page: () => CustomerFidelitiesPage(), transition: Transition.cupertino),
      GetPage(name: '/progress', page: () => CheckpointProgressPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => CheckpointSuccessPage(), transition: Transition.cupertino),
      GetPage(name: '/completed', page: () => CheckpointCompletedPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/enterprises',
    page: () => EnterpriseListPage(),
    binding: BindingsBuilder(() => Get.put(() => EnterpriseController())),
    children: [
      GetPage(name: '/enterprise_promotions', page: () => EnterprisePromotionsPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(name: '/settings', page: () => SettingsPage(), children: [
    GetPage(
        name: '/enterprise_profile',
        page: () => EnterpriseProfilePage(),
        transition: Transition.cupertino,
        children: [
          GetPage(name: '/success', page: () => EnterpriseSuccessPage(), transition: Transition.cupertino),
        ]),
    GetPage(name: '/about', page: () => AboutPage(), transition: Transition.cupertino)
  ]),
  GetPage(
    name: '/customer/profile',
    page: () => CustomerProfilePage(),
    binding: BindingsBuilder(() => Get.put<CustomerController>(new CustomerController())),
    children: [
      GetPage(name: '/success', page: () => CustomerSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/employee',
    page: () => EmployeeListPage(),
    binding: BindingsBuilder(() => Get.put<EmployeeController>(new EmployeeController())),
    children: [
      GetPage(name: '/add', page: () => EmployeeAddPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => EmployeeSuccessPage(), transition: Transition.cupertino),
    ],
  ),
  GetPage(
    name: '/category',
    page: () => CategoryListPage(),
    binding: BindingsBuilder(() => Get.put<CategoryController>(new CategoryController())),
    children: [
      GetPage(name: '/add', page: () => CategoryAddPage(), transition: Transition.cupertino),
      GetPage(name: '/success', page: () => CategorySuccessPage(), transition: Transition.cupertino),
    ],
  ),
];

getRoutes() {
  return List.of(routes);
}

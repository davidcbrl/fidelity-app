import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/models/navigation_item.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_page.dart';
import 'package:fidelity/pages/enterprises/enterprise_list_page.dart';
import 'package:fidelity/pages/dashboard/dashboard_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/settings/settings_page.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../products/product_list_page.dart';

class HomePage extends StatefulWidget {
  final pageIndex;

  HomePage({this.pageIndex = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetStorage box = GetStorage();
  PageController pageController = new PageController();
  RouteController routeController = Get.put(RouteController(), permanent: true);
  AuthController authController = Get.put(AuthController());

  static List<NavigationItem> userMenu = [];
  static List<NavigationItem> navigationMenu = [
    NavigationItem(
      label: 'Início',
      icon: Icons.home_outlined,
      page: DashboardPage(),
    ),
    NavigationItem(
      label: 'Fidelidades',
      icon: Icons.verified_user_outlined,
      page: FidelityListPage(),
      access: 'E',
    ),
    NavigationItem(
      label: 'Checkpoint',
      icon: Icons.qr_code_outlined,
      page: CheckpointPage(),
      access: 'E',
    ),
    NavigationItem(
      label: 'Código',
      icon: Icons.qr_code_outlined,
      page: CheckpointPage(),
      access: 'C',
    ),
    NavigationItem(
      label: 'Produtos',
      icon: Icons.shopping_cart_outlined,
      page: ProductListPage(),
      access: 'E',
    ),
    NavigationItem(
      label: 'Promoções',
      icon: Icons.percent_outlined,
      page: EnterpriseListPage(),
      access: 'C',
    ),
    NavigationItem(
      label: 'Ajustes',
      icon: Icons.settings_outlined,
      page: SettingsPage(),
    ),
  ];

  @override
  void initState() {
    var user = box.hasData('user') ? box.read('user') : User();
    authController.user.value = user is User ? user : User.fromJson(user);
    pageController = new PageController(initialPage: widget.pageIndex ?? 0);
    routeController.pageIndex.value = widget.pageIndex ?? 0;
    userMenu = navigationMenu.where(
      (NavigationItem item) => (item.access == null) || (item.access == authController.user.value.type)
    ).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        pageSnapping: false,
        onPageChanged: (index) {
          routeController.pageIndex.value = index;
        },
        children: userMenu.map(
          (NavigationItem item) => item.page ?? Container(),
        ).toList(),
      ),
      bottomBar: Obx(
        () => BottomNavigationBar(
          currentIndex: routeController.pageIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          items: userMenu.map(
            (NavigationItem item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          ).toList(),
          onTap: (index) {
            routeController.pageIndex.value = index;
            pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}

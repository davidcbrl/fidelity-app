import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/pages/code/code_page.dart';
import 'package:fidelity/pages/dashboard/dashboard_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/products/product_list_page.dart';
import 'package:fidelity/pages/settings/settings_page.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late PageController pageController;
  RouteController routeController = Get.put(RouteController(), permanent: true);

  final menu = <String>[
    'Início',
    'Fidelidades',
    'Código',
    'Produtos',
    'Ajustes',
  ];

  final menuIcons = <IconData>[
    Icons.home_outlined,
    Icons.verified_user_outlined,
    Icons.qr_code_outlined,
    Icons.shopping_cart_outlined,
    Icons.settings_outlined
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: routeController.pageIndex.value);
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
          setState(() {
            routeController.pageIndex.value = index;
          });
        },
        children: <Widget>[
          DashboardPage(),
          FidelityListPage(),
          CodePage(),
          ProductListPage(),
          SettingsPage(),
        ],
      ),
      bottomBar: BottomNavigationBar(
        currentIndex: routeController.pageIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondaryVariant,
        items: List.generate(menu.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(menuIcons[index]),
            label: menu[index],
          );
        }),
        onTap: (index) {
          setState(() {
            routeController.pageIndex.value = index;
            pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
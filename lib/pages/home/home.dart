import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/route_controller.dart';
import 'package:fidelity/models/navigation_item.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_page.dart';
import 'package:fidelity/pages/dashboard/customer_dashboard_page.dart';
import 'package:fidelity/pages/enterprises/enterprise_list_page.dart';
import 'package:fidelity/pages/dashboard/enterprise_dashboard_page.dart';
import 'package:fidelity/pages/fidelities/fidelity_list_page.dart';
import 'package:fidelity/pages/products/product_list_page.dart';
import 'package:fidelity/pages/settings/settings_page.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_responsive_layout.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
      page: EnterpriseDashboardPage(),
      access: 'E',
    ),
    NavigationItem(
      label: 'Início',
      icon: Icons.home_outlined,
      page: CustomerDashboardPage(),
      access: 'C',
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
    if (!box.hasData('jwt')) {
      authController.logout();
      return;
    }
    if (box.hasData('jwtDate')) {
      DateTime jwtDate = box.read('jwtDate');
      if (jwtDate.isBefore(DateTime.now())) {
        authController.logout();
        return ;
      }
    }
    var user = box.hasData('user') ? box.read('user') : User();
    authController.user.value = user is User ? user : User.fromJson(user);
    pageController = new PageController(initialPage: widget.pageIndex ?? 0);
    routeController.pageIndex.value = widget.pageIndex ?? 0;
    bool isEmployee = false;
    if (authController.user.value.type == 'F') {
      isEmployee = true;
      authController.user.value.type = 'E';
    }
    userMenu = navigationMenu.where(
      (NavigationItem item) => (item.access == null) || (item.access == authController.user.value.type)
    ).toList();
    if (authController.user.value.type == 'C') {
      _oneSignalSubscription();
    }
    if (isEmployee) {
      authController.user.value.type = 'F';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FidelityResponsiveLayout(
      mobile: FidelityPage(
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            routeController.pageIndex.value = index;
          },
          children: userMenu.map(
            (NavigationItem item) => item.page,
          ).toList(),
        ),
        bottomBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 10,
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
      ),
      desktop: FidelityPage(
        hasPadding: false,
        body: Row(
          children: [
            Expanded(
              flex: MediaQuery.of(context).size.width < 1000 ? 3 : 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Drawer(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  elevation: 10,
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset(
                            'assets/img/logo-text.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userMenu.length,
                          itemBuilder: (BuildContext context, int index) {
                            NavigationItem item = userMenu[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.only(left: 30, right: 10),
                              selected: routeController.pageIndex.value == index,
                              selectedTileColor: Theme.of(context).colorScheme.surface,
                              leading: Icon(
                                item.icon,
                                color: routeController.pageIndex.value == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
                              ),
                              title: Text(
                                item.label,
                                style: routeController.pageIndex.value == index ? Theme.of(context).textTheme.headline2 : Theme.of(context).textTheme.bodyText1,
                              ),
                              onTap: () {
                                routeController.pageIndex.value = index;
                                pageController.jumpToPage(index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: MediaQuery.of(context).size.width < 1000 ? 7 : 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  onPageChanged: (index) {
                    routeController.pageIndex.value = index;
                  },
                  children: userMenu.map(
                    (NavigationItem item) => item.page,
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _oneSignalSubscription() {
    OneSignal.shared.setExternalUserId(
      authController.user.value.customer!.cpf.toString(),
    ).then((results) {
      print('External id result: ${results.toString()}');
    }).catchError((error) {
      print('External id error: ${error.toString()}');
    });
  }

  Future<dynamic> logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Sair',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          'Tem certeza que deseja sair?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FidelityButton(
              label: 'Sim',
              onPressed: () {
                Get.back();
                authController.logout();
              },
            ),
          ),
          Center(
            child: FidelityTextButton(
              label: 'Não',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

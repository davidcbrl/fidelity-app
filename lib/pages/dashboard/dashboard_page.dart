import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Dashboard',
        hasBackButton: false,
      ),
      body: DashboardBody(),
    );
  }
}

class DashboardBody extends StatefulWidget {
  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  GetStorage box = GetStorage();
  AuthController authController = Get.find();

  Map<String, String> userImages = {
    'E': 'assets/img/company.png',
    'C': 'assets/img/user.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        FidelityUserHeader(
          imagePath: userImages[authController.user.type] ?? 'assets/img/company.png',
          name: authController.user.name ?? 'Luke Skywalker',
          description: 'Bem vindo!',
        ),
        SizedBox(
          height: 40,
        ),
        if (authController.user.type == 'E') ...[
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'assets/img/dashboard.gif',
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 125,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Esta é sua dashboard',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Aqui serão exibidos dados estatísticos de produtos e fidelidades ativas para auxiliar o seu negócio',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (authController.user.type == 'C') ...[
          Expanded(
            child: Container(),
          ),
        ],
      ],
    );
  }
}
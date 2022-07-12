import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EnterpriseDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Dashboard',
        hasBackButton: false,
      ),
      body: EnterpriseDashboardBody(),
    );
  }
}

class EnterpriseDashboardBody extends StatefulWidget {
  @override
  _EnterpriseDashboardBodyState createState() => _EnterpriseDashboardBodyState();
}

class _EnterpriseDashboardBodyState extends State<EnterpriseDashboardBody> {
  GetStorage box = GetStorage();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        FidelityUserHeader(
          imagePath: 'assets/img/enterprise.png',
          name: authController.user.value.name ?? 'Luke Skywalker',
          description: 'Bem vindo!',
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Stack(
            children: [
              Image.asset(
                'assets/img/enterprise-dashboard.gif',
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
                        'Aqui serão exibidas estatísticas sobre produtos, fidelidades e checkpoints para auxiliar o seu negócio!',
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
    );
  }
}
import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Dashboard',
        hasBackButton: false,
      ),
      body: CustomerDashboardBody(),
    );
  }
}

class CustomerDashboardBody extends StatefulWidget {
  @override
  _CustomerDashboardBodyState createState() => _CustomerDashboardBodyState();
}

class _CustomerDashboardBodyState extends State<CustomerDashboardBody> {
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
          imagePath: 'assets/img/user.jpg',
          name: authController.user.value.name ?? 'Chewie',
          description: 'Bem vindo!',
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Stack(
            children: [
              Image.asset(
                'assets/img/customer-dashboard.gif',
              ),
              Positioned(
                right: 20,
                child: Container(
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        'Esta é sua dashboard',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Aqui você acompanha o progresso de suas fidelidades e muito mais!',
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
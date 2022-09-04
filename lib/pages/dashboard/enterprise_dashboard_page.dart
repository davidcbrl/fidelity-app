import 'dart:convert';

import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_item_dash.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pie_chart/pie_chart.dart';

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
  EnterpriseController enterpriseController = EnterpriseController();

  @override
  void initState() {
    enterpriseController.getMostUsedLoyalts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(enterpriseController);
    List<Color> colorList = [Colors.blueAccent, Colors.blue.shade100, Colors.lightBlueAccent];
    return Obx(
      () => enterpriseController.loading.value
          ? FidelityLoading(loading: enterpriseController.loading.value)
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FidelityUserHeader(
                    image: Get.find<AuthController>().user.value.image != null
                        ? Image.memory(
                            base64Decode(Get.find<AuthController>().user.value.image ?? ''),
                            width: 50,
                          )
                        : Image.asset(
                            'assets/img/enterprise.png',
                            width: 50,
                          ),
                    name: authController.user.value.name ?? 'Luke Skywalker',
                    description: 'Bem vindo!',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  enterpriseController.dashboard.value.convertedList!.length == 0
                      ? emptyState(context)
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  FidelityItemDash(
                                    label: "Total de clientes fidelizados",
                                    description: "São os clientes que completaram a fidelidade e receberam promoção",
                                    valueNumber: enterpriseController.dashboard.value.totalClients != null
                                        ? enterpriseController.dashboard.value.totalClients.toString()
                                        : 0.toString(),
                                    icon: Icons.person_outline,
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FidelityItemDash(
                                    label: "Total de fidelidades cadastradas",
                                    description:
                                        "Incentive os clientes a participarem das fidelidades para mante-los fidelizados",
                                    valueNumber: enterpriseController.dashboard.value.totalLoyaltAchieved != null
                                        ? enterpriseController.dashboard.value.totalLoyaltAchieved.toString()
                                        : 0.toString(),
                                    icon: Icons.star_border,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: PieChart(
                                dataMap: enterpriseController.dashboard.value.convertedList!,
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 60,
                                chartRadius: MediaQuery.of(context).size.width / 2.2,
                                colorList: colorList,
                                centerText: "Top 3 fidelidades",
                                centerTextStyle:
                                    TextStyle(fontSize: 13, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 25,
                                legendOptions: LegendOptions(
                                  showLegendsInRow: true,
                                  legendPosition: LegendPosition.bottom,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: false,
                                  showChartValuesOutside: true,
                                  decimalPlaces: 2,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                ],
              ),
            ),
    );
  }

  Container emptyState(BuildContext context) {
    return Container(
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
    );
  }
}

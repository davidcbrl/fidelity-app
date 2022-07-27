import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
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
    List<Color> colorList = [Colors.orangeAccent, Colors.greenAccent, Colors.redAccent];
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
                    imagePath: 'assets/img/enterprise.png',
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
                            Container(
                              padding: EdgeInsets.only(top: 80),
                              child: PieChart(
                                dataMap: enterpriseController.dashboard.value.convertedList!,
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 60,
                                chartRadius: MediaQuery.of(context).size.width / 3.2,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 120,
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
                                  showChartValues: true,
                                  showChartValuesInPercentage: true,
                                  showChartValuesOutside: true,
                                  decimalPlaces: 2,
                                ),
                                // gradientList: ---To add gradient colors---
                                // emptyColorGradient: ---Empty Color gradient---
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text("Quantidade de clientes", textScaleFactor: 2),
                                    Text(
                                      enterpriseController.dashboard.value.totalClients.toString(),
                                      textScaleFactor: 2,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text("Quantidade de Fidelidades", textScaleFactor: 2),
                                    Text(enterpriseController.dashboard.value.totalLoyaltAchieved.toString(),
                                        textScaleFactor: 2),
                                  ],
                                )
                              ],
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

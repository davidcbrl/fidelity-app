import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
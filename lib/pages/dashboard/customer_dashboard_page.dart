import 'dart:convert';

import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/util/fidelity_utils.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_progress_item.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  CustomerController customerController = Get.put(CustomerController());
  AuthController authController = Get.find();

  @override
  void initState() {
    if (authController.user.value.customer!.cpf != null) {
      customerController.customerCPF.value = authController.user.value.customer!.cpf ?? '';
      customerController.getCustomerProgress();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        FidelityUserHeader(
          image: authController.user.value.image != null
            ? Image.memory(
                base64Decode(authController.user.value.image ?? ''),
                width: 50,
              )
            : Image.asset(
                'assets/img/user.jpg',
                width: 50,
              ),
          name: authController.user.value.name ?? 'Chewie',
          description: 'Bem vindo!',
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Obx(
            () => customerController.loading.value
            ? FidelityLoading(
                loading: customerController.loading.value,
                text: 'Carregando...',
              )
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    if (customerController.customerProgress.length > 0) ...[
                      ...customerController.customerProgress.map(
                        (Checkpoint progress) {
                          String type = FidelityUtils.types[progress.fidelity!.fidelityTypeId ?? 0];
                          String promotion = FidelityUtils.promotions[progress.fidelity!.promotionTypeId ?? 0];
                          return FidelityProgressItem(
                            label: progress.fidelity!.name ?? '',
                            description: '$type - $promotion',
                            typeId: progress.fidelity!.fidelityTypeId ?? 1,
                            progress: progress.score ?? 0.0,
                            target: progress.fidelity!.quantity ?? 0.0,
                            onPressed: () {},
                            icon: false,
                          );
                        },
                      ),
                    ],
                    if (customerController.customerProgress.length == 0) ...[
                      _buildEmptyState(context),
                    ],
                  ],
                ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _buildEmptyState(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Image.asset(
            'assets/img/customer-dashboard.gif',
          ),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Aqui você acompanha o progresso de suas fidelidades e muito mais!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
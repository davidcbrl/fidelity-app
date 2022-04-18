import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/models/customer_progress.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_progress_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerFidelitiesPage extends StatelessWidget {
  const CustomerFidelitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Progresso do cliente',
      ),
      body: Container(
        height: Get.height,
        child: CustomerFidelitiesBody(),
      ),
    );
  }
}

class CustomerFidelitiesBody extends StatelessWidget {
  CustomerController customerController = Get.find();
  List<String> types = [
    'Quantidade',
    'Pontuação',
    'Valor',
  ];
  List<String> promotions = [
    'Cupom de desconto',
    'Vale produto',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              child: Image.asset(
                'assets/img/user.jpg',
                width: 50,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Luke Skywalker',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Cliente desde 2020',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Selecione a fidelidade para atualizar',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        _progressList(),
        FidelityButton(
          label: 'Checkpoint',
          onPressed: () {
          },
        ),
        FidelityTextButton(
          label: 'Voltar',
          onPressed: () {
            Get.back();
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _progressList() {
    return Expanded(
      child: Obx(
        () => customerController.loading.value
        ? FidelityLoading(
            loading: customerController.loading.value,
            text: 'Carregando progresso do cliente...',
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                if (customerController.status.isSuccess)... [
                  ...customerController.customerProgress.map(
                    (CustomerProgress progress) {
                      return FidelityProgressItem(
                        id: progress.id ?? 1,
                        label: progress.fidelity!.name ?? '',
                        description: _buildProgressDescription(progress),
                        progress: progress.score ?? 0.0,
                        target: progress.fidelity!.quantity ?? 0.0,
                        selected: false,
                        onPressed: () {},
                      );
                    },
                  ),
                ],
                if (customerController.status.isEmpty)... [
                  FidelityEmpty(
                    text: 'Nenhum progresso encontrado',
                  ),
                ],
                if (customerController.status.isError)... [
                  FidelityEmpty(
                    text: customerController.status.errorMessage ?? '500',
                  ),
                ],
              ]
            ),
          ),
      ),
    );
  }

  String _buildProgressDescription(CustomerProgress progress) {
    DateTime startDate = DateTime.parse(progress.fidelity!.startDate ?? '');
    DateTime endDate = DateTime.parse(progress.fidelity!.endDate ?? '');
    String validity = DateFormat('dd/MM/yyyy').format(startDate) + ' - ' + DateFormat('dd/MM/yyyy').format(endDate);
    String desc = 'Fidelização: ' + types[progress.fidelity!.fidelityTypeId ?? 0] + '\n' +
                  'Promoção: ' + promotions[progress.fidelity!.promotionTypeId ?? 0] + '\n' +
                  'Vigência: ' + validity;
    return desc;
  }
}

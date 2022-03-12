import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fidelity_controller.dart';
import '../../models/fidelity_type.dart';
import '../../widgets/fidelity_appbar.dart';
import '../../widgets/fidelity_loading.dart';
import '../../widgets/fidelity_text_button.dart';

class FidelityConditionTypePage extends StatelessWidget {
  const FidelityConditionTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Selecione o tipo de fidelizacão',
        hasBackButton: false,
      ),
      body: FidelityConditionTypeBody(),
    );
  }
}

class FidelityConditionTypeBody extends StatelessWidget {
  FidelityConditionTypeBody({Key? key}) : super(key: key);
  FidelityController fidelityController = Get.find();
  List<FidelityType> _selectedFidelities = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'É a forma como o progresso do cliente será contabilizado para alcancar a promocão',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _fidelitiesList(),
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
      ),
    );
  }

  Widget _fidelitiesList() {
    return Expanded(
      child: Obx(
        () => !fidelityController.loading.value
            ? FidelityLoading(
                loading: fidelityController.loading.value,
                text: 'Carregando fidelidades...',
              )
            : SingleChildScrollView(
                child: Column(children: [
                  ...[
                    ...fidelityController.fakeFidelityTypeList().map(
                          (FidelityType fidelity) => FidelitySelectItem(
                            label: fidelity.name ?? '',
                            description: fidelity.description ?? '',
                            onPressed: () {
                              fidelityController.fidelity.value.type = fidelity;
                              Get.toNamed("/fidelity/condition");
                            },
                          ),
                        ),
                  ],
                ]),
              ),
      ),
    );
  }
}

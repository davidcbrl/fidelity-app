import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/fidelity_type.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityConditionTypePage extends StatelessWidget {
  const FidelityConditionTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Selecione o tipo de fidelizacão',
      ),
      body: FidelityConditionTypeBody(),
    );
  }
}

class FidelityConditionTypeBody extends StatelessWidget {
  FidelityConditionTypeBody({Key? key}) : super(key: key);
  FidelityController fidelityController = Get.find();

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
              'É a forma como o progresso do cliente será contabilizado para alcançar a promoção',
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
        () => fidelityController.loading.value
        ? FidelityLoading(
            loading: fidelityController.loading.value,
            text: 'Carregando fidelidades...',
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                ...fidelityController.fakeFidelityTypeList().map(
                  (FidelityType fidelityType) => FidelitySelectItem(
                    label: fidelityType.name ?? '',
                    description: fidelityType.description ?? '',
                    onPressed: () {
                      fidelityController.fidelity.value.fidelityTypeId = fidelityType.id;
                      Get.toNamed("/fidelity/condition");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

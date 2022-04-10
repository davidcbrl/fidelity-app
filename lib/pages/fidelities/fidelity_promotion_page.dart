import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityPromotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Selecione o tipo de promoção',
      ),
      body: FidelityPromotionBody(),
    );
  }
}

class FidelityPromotionBody extends StatelessWidget {
  FidelityController fidelityController = Get.find();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController promotionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (fidelityController.fidelity.value.id != null && fidelityController.fidelity.value.couponValue != null)
      promotionController.text = fidelityController.fidelity.value.couponValue!.toString();
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Informe qual será a promoção do cliente',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                FidelityTextFieldMasked(
                  controller: promotionController,
                  label: 'Cupom de desconto',
                  placeholder: 'R\$',
                  mask: '###',
                  icon: Icon(Icons.attach_money_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo vazio';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) formKey.currentState!.validate();
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          label: 'Próximo',
          onPressed: () {
            preSavePromotion();
          },
        ),
        FidelityTextButton(
          label: 'Voltar',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  void preSavePromotion() {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      fidelityController.fidelity.value.couponValue = double.parse(promotionController.text);
      Get.toNamed('/fidelity/cashout');
    }
  }
}

import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityConditionPage extends StatelessWidget {
  const FidelityConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Qual será a condicão da fidelidade?',
      ),
      body: FidelityConditionBody(),
    );
  }
}

class FidelityConditionBody extends StatelessWidget {
  FidelityConditionBody({Key? key}) : super(key: key);
  TextEditingController _quantityController = new TextEditingController();
  GlobalKey<FormState> _formFidelityConditionKey = new GlobalKey<FormState>();
  FidelityController fidelityController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (fidelityController.fidelity.value.id != null)
      _quantityController.text = fidelityController.fidelity.value.quantity!.round().toString();
    return Container(
      child: Form(
        key: _formFidelityConditionKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Informe qual será a condição para que o cliente complete a fidelidade e conquiste a promoção',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FidelityTextFieldMasked(
                    controller: _quantityController,
                    label: 'Quantidade',
                    placeholder: '10',
                    mask: '###',
                    icon: Icon(Icons.production_quantity_limits),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo vazio';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) _formFidelityConditionKey.currentState!.validate();
                    },
                  ),
                ],
              ),
            ),
            FidelityButton(
              label: 'Próximo',
              onPressed: () {
                _preSaveFidelity();
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
        ),
      ),
    );
  }

  _preSaveFidelity() {
    final FormState? form = _formFidelityConditionKey.currentState;
    if (form!.validate()) {
      fidelityController.fidelity.value.quantity = double.parse(_quantityController.text);
      Get.toNamed('/fidelity/promotion_type');
    }
  }
}

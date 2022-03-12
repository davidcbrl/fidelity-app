import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/fidelity.dart';
import '../../widgets/fidelity_appbar.dart';
import '../../widgets/fidelity_button.dart';
import '../../widgets/fidelity_loading.dart';
import '../../widgets/fidelity_text_button.dart';
import '../../widgets/fidelity_text_field_masked.dart';

class FidelityAddPage extends StatelessWidget {
  const FidelityAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Nova Fidelidade',
      ),
      body: Container(height: Get.height, child: FidelityAddBody()),
    );
  }
}

class FidelityAddBody extends StatelessWidget {
  FidelityAddBody({Key? key}) : super(key: key);

  FidelityController fidelityController = Get.find<FidelityController>();
  GlobalKey<FormState> _formFidelityAddKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _initDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !fidelityController.loading.value
          ? FidelityLoading(
              loading: fidelityController.loading.value,
              text: 'Salvando fidelidade...',
            )
          : Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formFidelityAddKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FidelityTextFieldMasked(
                              controller: _nameController,
                              label: 'Nome',
                              placeholder: 'Nome da fidelidade',
                              icon: Icon(Icons.person_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formFidelityAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("A fidelidade tera periodo de vigencia?",
                                      style: Theme.of(context).textTheme.bodyText2),
                                ),
                                Icon(Icons.question_mark)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityTextFieldMasked(
                              controller: _initDateController,
                              label: 'Data de inicio',
                              placeholder: 'dd/mm/aaaa',
                              icon: Icon(Icons.calendar_month),
                              mask: '##/##/####',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formFidelityAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityTextFieldMasked(
                              controller: _endDateController,
                              label: 'Data de vencimento',
                              placeholder: 'dd/mm/aaaa',
                              icon: Icon(Icons.calendar_month),
                              mask: '##/##/####',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formFidelityAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FidelityButton(
                    label: 'Próximo',
                    onPressed: () {
                      _firstSaveFidelity(context);
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

  void _firstSaveFidelity(BuildContext context) async {
    final FormState? form = _formFidelityAddKey.currentState;
    if (form!.validate()) {
      fidelityController.fidelity.value = new Fidelity(
        companyId: 2,
        name: _nameController.text,
        initDate: _initDateController.text,
        endDate: _endDateController.text,
      );
      Get.toNamed("/fidelity/condition");
    }
  }
}

import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _initDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Obx(
      () => fidelityController.loading.value
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityTextFieldMasked(
                              controller: _descriptionController,
                              label: 'Descricao',
                              placeholder: 'Descricao da fidelidade',
                              icon: Icon(Icons.person_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'A fidelidade terá periodo de vigência?',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Icon(
                                  Icons.question_mark,
                                  color: Theme.of(context).colorScheme.secondaryVariant,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityTextFieldMasked(
                              controller: _initDateController,
                              label: 'Data de inicio',
                              placeholder: 'dd-mm-aaaa',
                              icon: Icon(Icons.calendar_month),
                              mask: '##-##-####',
                              validator: (value) {
                                if (_dateTransform(value) == null) return "Digite uma data valido";

                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
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
                              mask: '##-##-####',
                              validator: (value) {
                                if (_dateTransform(value) == null) return "Digite uma data valido";
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Obx(() => fidelityController.isInvalid.value
                                ? Center(
                                    child: Text(
                                      "A data final deve ser maior que a inicial",
                                      style: TextStyle(color: Theme.of(context).errorColor),
                                    ),
                                  )
                                : Container())
                          ],
                        ),
                      ),
                    ),
                  ),
                  FidelityButton(
                    label: 'Próximo',
                    onPressed: () {
                      _formFidelityAddKey.currentState!.validate();
                      if (DateTime.parse(_dateTransform(_initDateController.text)!)
                              .difference(DateTime.parse(_dateTransform(_endDateController.text)!)) >
                          Duration.zero) {
                        fidelityController.isInvalid.value = true;
                        return;
                      }
                      fidelityController.isInvalid.value = false;
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

  String? _dateTransform(String? date) {
    if (date == null) return null;
    var dates = date.split('-');
    if (int.parse(dates[2]) > 3000) return null;
    if (int.parse(dates[2]) < 2000) return null;
    if (int.parse(dates[2]) == 0000) return null;
    if (int.parse(dates[1]) > 12) return null;
    if (int.parse(dates[1]) == 00) return null;
    if (int.parse(dates[0]) > 31) return null;
    if (int.parse(dates[0]) == 00) return null;
    if (dates[1] == "02") {
      if (int.parse(dates[0]) > 28) return null;
    }
    if (int.parse(dates[1]) != 2 && int.parse(dates[1]) < 8) {
      if (int.parse(dates[1]) % 2 == 0) if (int.parse(dates[0]) > 30) return null;
    }
    if (int.parse(dates[1]) != 2 && int.parse(dates[1]) >= 8) {
      if (int.parse(dates[1]) % 2 != 0) if (int.parse(dates[0]) > 30) return null;
    }

    var result = dates[2] + '-' + dates[1] + '-' + dates[0];
    return result;
  }

  void _firstSaveFidelity(BuildContext context) async {
    final FormState? form = _formFidelityAddKey.currentState;
    if (form!.validate()) {
      fidelityController.fidelity.value = new Fidelity(
        companyId: 2,
        name: _nameController.text,
        description: _descriptionController.text,
        initDate: _initDateController.text,
        endDate: _endDateController.text,
      );
      Get.toNamed("/fidelity/condition_type");
    }
  }
}

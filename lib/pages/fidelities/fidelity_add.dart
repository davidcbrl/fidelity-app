import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FidelityAddPage extends StatelessWidget {
  FidelityAddPage(this.fidelity, {Key? key}) : super(key: key);
  Fidelity? fidelity;

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Nova Fidelidade',
      ),
      body: Container(
          height: Get.height,
          child: FidelityAddBody(
            fidelity: fidelity,
          )),
    );
  }
}

class FidelityAddBody extends StatelessWidget {
  FidelityAddBody({this.fidelity, Key? key}) : super(key: key);
  Fidelity? fidelity;
  FidelityController fidelityController = Get.find<FidelityController>();
  GlobalKey<FormState> _formFidelityAddKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _initDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    fidelity != null ? fidelityController.fidelity.value = fidelity! : Fidelity();
    if (fidelity != null) {
      var format = DateFormat.yMd();
      _nameController.text = fidelity!.name!;
      _descriptionController.text = fidelity!.description!;
      if (fidelity!.startDate != null) {
        if (fidelity!.startDate!.length >= 10) {
          _initDateController.text = format.format(DateTime.parse(fidelity!.startDate!.split("T")[0]));
          if (_initDateController.text.split("/")[0].length == 1)
            _initDateController.text = "0" + _initDateController.text;
          if (_initDateController.text.split("/")[1].length == 1) {
            _initDateController.text = _initDateController.text.split("/")[0] +
                "/" +
                "0" +
                _initDateController.text.split("/")[1] +
                "/" +
                _initDateController.text.split("/")[2];
          }
        } else
          _initDateController.text = fidelity!.startDate!;
      }
      if (fidelity!.endDate != null) {
        if (fidelity!.endDate!.length >= 10) {
          _endDateController.text = format.format(DateTime.parse(fidelity!.endDate!.split("T")[0]));
          if (_endDateController.text.split("/")[0].length == 1)
            _endDateController.text = "0" + _endDateController.text;
          if (_endDateController.text.split("/")[1].length == 1) {
            _endDateController.text = _endDateController.text.split("/")[0] +
                "/" +
                "0" +
                _endDateController.text.split("/")[1] +
                "/" +
                _endDateController.text.split("/")[2];
          }
        } else
          _endDateController.text = fidelity!.endDate!;
      }
    }

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
                              readOnly: fidelity != null,
                              icon: Icon(Icons.label_important_outline),
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
                              readOnly: fidelity != null,
                              label: 'Descrição',
                              placeholder: 'Detalhes da fidelidade',
                              icon: Icon(Icons.list_alt_outlined),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Periodo de vigência',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FidelityTextFieldMasked(
                              controller: _initDateController,
                              label: 'Data de inicio',
                              readOnly: fidelity != null,
                              placeholder: 'dd/mm/aaaa',
                              icon: Icon(Icons.calendar_month),
                              mask: '##/##/####',
                              validator: (value) {
                                if (_dateTransform(value) == null) return "Digite uma data valido";

                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FidelityTextFieldMasked(
                              controller: _endDateController,
                              label: 'Data de vencimento',
                              readOnly: fidelity != null,
                              placeholder: 'dd/mm/aaaa',
                              icon: Icon(Icons.calendar_month),
                              mask: '##/##/####',
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
                            Obx(() => fidelityController.isInvalid.value
                                ? Center(
                                    child: Text(
                                      "A data final deve ser maior que a inicial",
                                      style: TextStyle(color: Theme.of(context).errorColor),
                                    ),
                                  )
                                : Container()),
                            if (fidelity != null)
                              Column(
                                children: [
                                  if (fidelity?.quantity != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Fidelizacao",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FidelitySelectItem(
                                          label: "Quantidade: ${fidelity?.quantity}",
                                          //description: "Clique aqui para editar a fidelizacao",
                                          onPressed: () {
                                            return;
                                            //Get.toNamed("/fidelity/condition");
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Promocao",
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      FidelitySelectItem(
                                        label:
                                            "${fidelity?.promotionTypeId != null ? fidelity!.promotionTypeId!.isOdd ? 'Cupom de desconto' : 'Vale produto' : ''} R\$ ${fidelity?.couponValue == null ? 0 : fidelity?.couponValue}",
                                        // description: "Clique aqui para editar a promocao",
                                        onPressed: () {
                                          return;
                                          // Get.toNamed("/fidelity/promotion");
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  if (fidelity?.products != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Produtos Vinculados",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FidelitySelectItem(
                                          label: "${fidelity?.products?.length} Produtos",
                                          //description: "Clique aqui para editar os produtos vinculados",
                                          onPressed: () {
                                            return;
                                            // Get.toNamed("/fidelity/cashout", arguments: fidelity?.products);
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (fidelity == null)
                    Column(
                      children: [
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
                ],
              ),
            ),
    );
  }

  String? _dateTransform(String? date) {
    if (date == null || date == "") return null;
    var dates = date.split('/');
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
      fidelityController.fidelity.value.name = _nameController.text;
      fidelityController.fidelity.value.description = _descriptionController.text;
      fidelityController.fidelity.value.startDate = _initDateController.text;
      fidelityController.fidelity.value.endDate = _endDateController.text;
      fidelityController.fidelity.value.fidelityTypeId != null
          ? Get.toNamed("/fidelity/condition")
          : Get.toNamed("/fidelity/condition_type");
    }
  }
}

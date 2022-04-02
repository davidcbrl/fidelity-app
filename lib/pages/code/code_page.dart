import 'package:fidelity/controllers/code_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CodeController controller = CodeController();
    Get.put(controller);
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Escanear Código QR do cliente',
        hasBackButton: false,
      ),
      body: CodeBody(),
    );
  }
}

class CodeBody extends StatelessWidget {
  CodeController controller = Get.find();
  TextEditingController _cpfController = TextEditingController();
  final _formCodeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? FidelityLoading(
              loading: controller.loading.value,
              text: 'Carregando...',
            )
          : Container(
              padding: EdgeInsets.only(top: 10),
              child: Form(
                key: _formCodeKey,
                child: Column(
                  children: [
                    FidelityTextFieldMasked(
                      controller: _cpfController,
                      label: "Verificar por cpf",
                      placeholder: "000.000.000-00",
                      icon: Icon(Icons.person_outline),
                      mask: '###.###.###-##',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo vazio';
                        }
                        if (value.isNotEmpty && value.length < 11) {
                          return 'Digite um cpf valido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        Future.delayed(Duration(milliseconds: 1500), () {
                          if (_formCodeKey.currentState!.validate()) {
                            Get.toNamed("/code/customer_fidelities");
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

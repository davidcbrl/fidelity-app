import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class CheckpointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerController customerController = CustomerController();
    Get.put(customerController);

    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Checkpoint',
        hasBackButton: false,
      ),
      body: CheckpointBody(),
    );
  }
}

class CheckpointBody extends StatefulWidget {
  const CheckpointBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckpointBodyState();
}

class _CheckpointBodyState extends State<CheckpointBody> {
  CustomerController customerController = Get.find();
  FidelityController fidelityController = Get.put(FidelityController());
  AuthController authController = Get.find();
  Barcode? result;
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController _cpfController = TextEditingController();
  final _formCodeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => customerController.loading.value
          ? FidelityLoading(
              loading: customerController.loading.value,
              text: 'Carregando...',
            )
          : Container(
              padding: EdgeInsets.only(top: 15),
              child: Form(
                key: _formCodeKey,
                child: Column(
                  children: [
                    if (authController.user.value.type == 'E') ...[
                      FidelityTextFieldMasked(
                        controller: _cpfController,
                        label: "Verificar por CPF",
                        placeholder: "000.000.000-00",
                        icon: Icon(Icons.person_outline),
                        mask: '###.###.###-##',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo vazio';
                          }
                          if (value.isNotEmpty && value.length < 14) {
                            return 'Digite um CPF valido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          value = value.length > 0 ? value.replaceAll(new RegExp(r'[^0-9]'), '') : value;
                          if (_formCodeKey.currentState!.validate()) {
                            getCustomerProgress(value);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/img/qr-code.gif',
                          ),
                          Positioned(
                            right: 0,
                            top: 150,
                            child: Container(
                              width: 175,
                              child: FidelityButton(
                                label: 'Escanear QR Code do cliente',
                                labelAlignment: TextAlign.center,
                                onPressed: () {
                                  Get.toNamed('/checkpoint/scan');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (authController.user.value.type == 'C') ...[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              authController.user.value.customer?.cpf ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Center(
                            //   child: QrImage(
                            //     data: authController.user.value.customer?.cpf ?? '',
                            //     version: QrVersions.isSupportedVersion(3) ? 3 : QrVersions.auto,
                            //     size: 250.0,
                            //     embeddedImage: AssetImage('assets/img/logo.png'),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> getCustomerProgress(String cpf) async {
    if (cpf.isNotEmpty) {
      fidelityController.filter.value = '';
      fidelityController.fidelitiesList.clear();
      fidelityController.getFidelities();
      customerController.customerCPF.value = cpf;
      await customerController.getCustomerProgress();
      if (customerController.status.isSuccess) {
        customerController.loading.value = false;
        Get.toNamed('/checkpoint/customer_fidelities');
        return;
      }
      customerController.loading.value = false;
      _showErrorDialog(context);
    }
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Checkpoint',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          customerController.status.errorMessage ?? 'Erro ao buscar progresso do cliente',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FidelityButton(
              label: 'OK',
              width: double.maxFinite,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}

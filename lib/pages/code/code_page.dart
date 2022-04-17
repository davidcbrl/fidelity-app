import 'package:fidelity/controllers/code_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerController customerController = CustomerController();
    Get.put(customerController);

    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Escanear Código QR do cliente',
        hasBackButton: false,
      ),
      body: CodeBody(),
    );
  }
}

class CodeBody extends StatefulWidget {
  const CodeBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeBodyState();
}

class _CodeBodyState extends State<CodeBody> {
  CustomerController customerController = Get.find();
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
          padding: EdgeInsets.only(top: 10),
          child: Form(
            key: _formCodeKey,
            child: Column(
              children: [
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
                    if (value.isNotEmpty && value.length < 11) {
                      return 'Digite um CPF valido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    Future.delayed(Duration(milliseconds: 1500), () {
                      if (_formCodeKey.currentState!.validate()) {
                        getCustomerProgress(value);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildQrView(context),
                      ),
                      if (result != null) ...[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: FidelityButton(
                                label: 'Checkpoint pelo CPF: ${result!.code}',
                                onPressed: () {
                                  getCustomerProgress(result!.code ?? '');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 200.0;

    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.back,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).colorScheme.error,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sem permissão'),
        ),
      );
    }
  }

  Future<void> getCustomerProgress(String cpf) async {
    if (cpf.isNotEmpty) {
      customerController.customerCPF.value = cpf;
      await customerController.getCustomerProgress();
      if (customerController.status.isSuccess) {
        customerController.loading.value = false;
        Get.toNamed('/code/customer_fidelities');
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
          'Funcionários',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          customerController.status.errorMessage ?? 'Erro ao buscar progresso do cliente',
          style: Theme.of(context).textTheme.bodyText1,
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

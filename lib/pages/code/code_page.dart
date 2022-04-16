import 'package:fidelity/controllers/code_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widgets/fidelity_text_field_masked.dart';

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

class CodeBody extends StatefulWidget {
  const CodeBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeBodyState();
}

class _CodeBodyState extends State<CodeBody> {
  Barcode? result;
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController _cpfController = TextEditingController();
  final _formCodeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CodeController controller = Get.find();
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 500,
                      child: Column(
                        children: <Widget>[
                          Expanded(flex: 1, child: _buildQrView(context)),
                          Expanded(
                            flex: 1,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  if (result != null)
                                    Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                                  else
                                    Text('Escaneie um QR Code', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
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
        print(result!.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}

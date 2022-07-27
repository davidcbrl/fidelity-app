import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CheckpointScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerController customerController = CustomerController();
    Get.put(customerController);

    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Escanear QR Code',
      ),
      body: CheckpointScannerBody(),
    );
  }
}

class CheckpointScannerBody extends StatefulWidget {
  const CheckpointScannerBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckpointScannerBodyState();
}

class _CheckpointScannerBodyState extends State<CheckpointScannerBody> {
  CustomerController customerController = Get.find();
  FidelityController fidelityController = Get.find();
  AuthController authController = Get.find();
  Barcode? result;
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
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
                        padding: const EdgeInsets.all(20),
                        child: FidelityButton(
                          label: 'Checkpoint pelo CPF: ${result!.code}',
                          onPressed: () {
                            getCustomerProgress(result!.code ?? '');
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
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
          content: Text('Por favor, autorize uso de câmera no seu dispositivo'),
        ),
      );
    }
  }

  Future<void> getCustomerProgress(String cpf) async {
    if (cpf.isNotEmpty) {
      fidelityController.filter.value = '';
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

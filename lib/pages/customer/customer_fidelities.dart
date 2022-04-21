import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/models/customer_progress.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_progress_item.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerFidelitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Progresso do cliente',
      ),
      hasPadding: false,
      body: Container(
        height: Get.height,
        child: CustomerFidelitiesBody(),
      ),
    );
  }
}

class CustomerFidelitiesBody extends StatefulWidget {
  @override
  State<CustomerFidelitiesBody> createState() => _CustomerFidelitiesBodyState();
}

class _CustomerFidelitiesBodyState extends State<CustomerFidelitiesBody> {
  CustomerController customerController = Get.find();
  FidelityController fidelityController = Get.put(FidelityController());
  List<Fidelity> _selectedFidelities = [];
  List<String> types = [
    'Quantidade',
    'Pontuação',
    'Valor',
  ];
  List<String> promotions = [
    'Cupom de desconto',
    'Vale produto',
  ];

  @override
  void initState() {
    if (customerController.customerProgress.value.length > 0) {
      customerController.customerProgress.value.forEach((CustomerProgress progress) {
        if (progress.fidelity != null) {
          _selectedFidelities.add(progress.fidelity!);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FidelityUserHeader(
                  imagePath: 'assets/img/user.jpg',
                  name: 'Chewie',
                  description: 'Prospect',
                  imageBorderRadius: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Fidelidades disponíveis',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                _fidelitiesList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        _progressCart(context),
      ],
    );
  }

  Widget _fidelitiesList() {
    return Expanded(
      child: Obx(
        () => fidelityController.loading.value
        ? FidelityLoading(
            loading: fidelityController.loading.value,
            text: 'Carregando fidelidades...',
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                if (fidelityController.status.isSuccess)... [
                  ...fidelityController.fidelitiesList.map(
                    (Fidelity fidelity) {
                      fidelity.products = null;
                      return FidelityLinkItem(
                        id: fidelity.id ?? 1,
                        label: fidelity.name ?? '',
                        description: fidelity.description ?? '',
                        selected: containsFidelityId(fidelity.id),
                        onPressed: () {
                          if (containsFidelityId(fidelity.id)) {
                            setState(() {
                              _selectedFidelities.removeWhere((element) => element.id == fidelity.id);
                            });
                            return;
                          }
                          setState(() {
                            _selectedFidelities.add(fidelity);
                          });
                        },
                      );
                    },
                  ),
                ],
                if (fidelityController.status.isEmpty)... [
                  FidelityEmpty(
                    text: 'Nenhuma fidelidade encontrada',
                  ),
                ],
                if (fidelityController.status.isError)... [
                  FidelityEmpty(
                    text: fidelityController.status.errorMessage ?? '500',
                  ),
                ],
              ]
            ),
          ),
      ),
    );
  }

  bool containsFidelityId(int? id) {
    for (dynamic e in _selectedFidelities) {
      if (e.id == id) return true;
    }
    return false;
  }

  Widget _progressCart(BuildContext context) {
    return InkWell(
      onTap: () {
        _progressBottomSheet(context);
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: _selectedFidelities.length > 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: _selectedFidelities.length > 0
          ? Text(
              'Fidelidades selecionadas para checkpoint: ${_selectedFidelities.length}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button,
            )
          : Text(
              'Selecione as fidelidades que deseja atualizar o progresso do cliente',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
        ),
      ),
    );
  }

  Future<void> _progressBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          height: Get.height - Get.height * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              if (_selectedFidelities.length > 0) ...[
                Text(
                  'Fidelidades selecionadas para checkpoint: ${_selectedFidelities.length}',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
              _progressList(),
            ],
          ),
        );
      },
    );
  }

  Widget _progressList() {
    return Expanded(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                if (_selectedFidelities.length > 0)... [
                  ..._selectedFidelities.map(
                    (Fidelity fidelity) {
                      CustomerProgress progress = CustomerProgress(
                        fidelity: fidelity,
                        score: 0,
                      );
                      return FidelityProgressItem(
                        label: progress.fidelity!.name ?? '',
                        description: _buildProgressDescription(progress),
                        progress: progress.score ?? 0.0,
                        target: progress.fidelity!.quantity ?? 0.0,
                        onPressed: () {
                          
                        },
                      );
                    },
                  ),
                ],
                if (_selectedFidelities.length == 0)... [
                  FidelityEmpty(
                    text: 'Selecione as fidelidades que deseja atualizar o progresso do cliente',
                  ),
                ],
              ],
            ),
            if (_selectedFidelities.length > 0)... [
              SizedBox(
                height: 20,
              ),
              FidelityButton(
                label: 'Checkpoint',
                onPressed: () {
                  checkpoint(context);
                },
              ),
            ],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String _buildProgressDescription(CustomerProgress progress) {
    String validity = 'N/A';
    if (progress.fidelity!.startDate != null || progress.fidelity!.endDate != null) {
      DateTime startDate = DateTime.parse(progress.fidelity!.startDate ?? '');
      DateTime endDate = DateTime.parse(progress.fidelity!.endDate ?? '');
      validity = DateFormat('dd/MM/yyyy').format(startDate) + ' - ' + DateFormat('dd/MM/yyyy').format(endDate);
    }
    String desc = 'Fidelização: ' + types[progress.fidelity!.fidelityTypeId ?? 0] + '\n' +
                  'Promoção: ' + promotions[progress.fidelity!.promotionTypeId ?? 0] + '\n' +
                  'Vigência: ' + validity;
    return desc;
  }

  Future<void> checkpoint(BuildContext context) async {
    customerController.loading.value = true;
    customerController.checkpoint.value = _selectedFidelities.map(
      (Fidelity fidelity) => new Checkpoint(
        customerId: 99,
        fidelityId: fidelity.id,
        value: 99,
      )
    ).toList();
    // await customerController.checkpoint();
    if (customerController.status.isSuccess) {
      customerController.loading.value = false;
      // Get.toNamed('/code/success');
      return;
    }
    customerController.loading.value = false;
    _showErrorDialog(context);
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Produtos',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          customerController.status.errorMessage ?? 'Erro ao salvar produto',
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
}

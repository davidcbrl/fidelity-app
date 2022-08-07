import 'package:fidelity/controllers/checkpoint_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/notification_controller.dart';
import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/models/one_signal_push.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_completed_page.dart';
import 'package:fidelity/pages/checkpoint/checkpoint_progress_page.dart';
import 'package:fidelity/util/fidelity_utils.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_progress_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_user_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
  GetStorage box = GetStorage();
  CheckpointController checkpointController = Get.put(CheckpointController());
  NotificationController notificationController = Get.put(NotificationController());
  FidelityController fidelityController = Get.find();
  CustomerController customerController = Get.find();
  ScrollController scrollController = new ScrollController();
  List<Checkpoint> _selectedForCheckpoint = [];

  @override
  void initState() {
    if (customerController.customerProgress.value.length > 0) {
      customerController.customerProgress.value.forEach((Checkpoint progress) {
        if (progress.fidelity != null) {
          progress.customerId = customerController.customer.value.id;
          _selectedForCheckpoint.add(progress);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => customerController.loading.value || checkpointController.loading.value
      ? FidelityLoading(
          loading: customerController.loading.value || checkpointController.loading.value,
          text: 'Carregando...',
        )
      : Column(
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
                      image: Image.asset(
                        'assets/img/user.jpg',
                        width: 50,
                      ),
                      name: customerController.customer.value.name ?? 'Chewie',
                      description: customerController.customer.value.cpf ?? 'CPF',
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
      ),
    );
  }

  Widget _fidelitiesList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: fidelityController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => fidelityController.getFidelitiesNextPage(),
          child: RefreshIndicator(
            onRefresh: () => _refresh(),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                if (!fidelityController.status.isError && fidelityController.fidelitiesList.length > 0)... [
                    ...fidelityController.fidelitiesList.map(
                      (Fidelity fidelity) {
                        fidelity.products = null;
                        return FidelityLinkItem(
                          id: fidelity.id ?? 1,
                          label: fidelity.name ?? '',
                          description: fidelity.description ?? '',
                          selected: containsFidelityId(fidelity.id),
                          active: fidelity.status ?? true,
                          onPressed: () {
                            if (containsFidelityId(fidelity.id)) {
                              setState(() {
                                _selectedForCheckpoint.removeWhere((Checkpoint progress) => progress.fidelity!.id == fidelity.id);
                              });
                              return;
                            }
                            setState(() {
                              _selectedForCheckpoint.add(new Checkpoint(
                                customerId: customerController.customer.value.id,
                                fidelity: fidelity,
                                score: 0,
                              ));
                            });
                          },
                        );
                      },
                    ),
                  ],
                  if (fidelityController.status.isLoading)... [
                    FidelityLoading(
                      loading: fidelityController.loading.value,
                      text: 'Carregando fidelidades...',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    fidelityController.page.value = 1;
    await fidelityController.getFidelities();
  }

  bool containsFidelityId(int? id) {
    for (Checkpoint progress in _selectedForCheckpoint) {
      if (progress.fidelity!.id == id) return true;
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
          color: _selectedForCheckpoint.length > 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: _selectedForCheckpoint.length > 0
          ? Text(
              'Fidelidades selecionadas para checkpoint: ${_selectedForCheckpoint.length}',
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
              if (_selectedForCheckpoint.length > 0) ...[
                Text(
                  'Fidelidades selecionadas para checkpoint: ${_selectedForCheckpoint.length}',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Clique sobre cada fidelidade para editar o progresso individualmente',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
              _progressList(),
              if (_selectedForCheckpoint.length > 0)... [
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Finalizar checkpoint',
                  onPressed: () {
                    Get.back();
                    checkpoint(context);
                  },
                ),
                FidelityTextButton(
                  label: 'Voltar',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
              SizedBox(
                height: 20,
              ),
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
                if (_selectedForCheckpoint.length > 0)... [
                  ..._selectedForCheckpoint.map(
                    (Checkpoint progress) {
                      String type = FidelityUtils.types[progress.fidelity!.fidelityTypeId ?? 0];
                      String promotion = FidelityUtils.promotions[progress.fidelity!.promotionTypeId ?? 0];
                      return FidelityProgressItem(
                        label: progress.fidelity!.name ?? '',
                        description: '$type - $promotion',
                        typeId: progress.fidelity!.fidelityTypeId ?? 1,
                        progress: (progress.originalScore ?? 0.0) + (progress.score ?? 0.0),
                        target: progress.fidelity!.quantity ?? 0.0,
                        onPressed: () {
                          Get.back();
                          Get.to(() => CheckpointProgressPage(progress: progress));
                        },
                      );
                    },
                  ),
                ],
                if (_selectedForCheckpoint.length == 0)... [
                  FidelityEmpty(
                    text: 'Selecione as fidelidades que deseja atualizar o progresso do cliente',
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkpoint(BuildContext context) async {
    checkpointController.loading.value = true;
    checkpointController.checkpoints.value = _selectedForCheckpoint.map(
      (Checkpoint progress) => new Checkpoint(
        enterpriseId: box.read('enterpriseId'),
        customerId: progress.customerId,
        fidelityId: progress.fidelity!.id,
        value: progress.score,
      )
    ).toList();
    await checkpointController.saveCheckpoint();
    if (checkpointController.status.isSuccess) {
      checkpointController.loading.value = false;
      List<Checkpoint> completed = checkpointController.checkpoints.value.where(
        (check) => check.completed ?? false,
      ).toList();
      if (completed.length > 0) {
        notificationController.push.value = OneSignalPush(
          includeExternalUserId: [customerController.customerCPF.value],
          name: 'Checkpoint',
          headings: 'Fidelidade completa!',
          contents: 'Você já pode receber a promoção, solicite ao estabelecimento',
        );
        await notificationController.sendPush();
        Get.to(() => CheckpointCompletedPage(completedCheckpoints: completed));
        return;
      }
      notificationController.push.value = OneSignalPush(
        includeExternalUserId: [customerController.customerCPF.value],
        name: 'Checkpoint',
        headings: 'Progresso atualizado',
        contents: 'Continue participando de fidelidades para receber promoções',
      );
      await notificationController.sendPush();
      Get.toNamed('/checkpoint/success');
      return;
    }
    checkpointController.loading.value = false;
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
          checkpointController.status.errorMessage ?? 'Erro ao realizar checkpoint',
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

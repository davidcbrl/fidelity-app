import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/models/plan.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ThirdStepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Cadastro',
      ),
      body: ThirdStepBody(),
    );
  }
}

class ThirdStepBody extends StatefulWidget {
  @override
  _ThirdStepBodyState createState() => _ThirdStepBodyState();
}

AuthController? authController = Get.find<AuthController>();

class _ThirdStepBodyState extends State<ThirdStepBody> {
  EnterpriseController enterpriseController = Get.find();

  @override
  void initState() {
    super.initState();
    enterpriseController.getPlans();
    if (Get.isRegistered<AuthController>() && Get.find<AuthController>().user.value.enterprise != null) {
      enterpriseController.plan.value.id = Get.find<AuthController>().user.value.enterprise!.membershipId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => enterpriseController.plansLoading.value
          ? FidelityLoading(
              loading: enterpriseController.plansLoading.value,
              text: 'Cadastrando-se...',
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FidelityStepper(
                  currentStep: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Quase lá... Escolha um de nossos planos, cada plano possui recursos diferentes, portanto, escolha o plano que for a cara do seu negócio!',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                _plansCarousel(),
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Concluir',
                  onPressed: () {
                    saveEnterprise(context);
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
    );
  }

  Widget _plansCarousel() {
    return Expanded(
      child: Obx(
        () => enterpriseController.plansLoading.value
            ? FidelityLoading(
                loading: enterpriseController.plansLoading.value,
                text: 'Carregando planos...',
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (enterpriseController.status.isSuccess) ...[
                      ...enterpriseController.plansList.map(
                        (Plan plan) {
                          String currency = NumberFormat.currency(locale: 'pt-br', symbol: 'R\$').format(plan.value);
                          return FidelityLinkItem(
                            label: plan.name! + ' - ' + currency,
                            description: plan.description ?? '',
                            selected: enterpriseController.plan.value.id == plan.id,
                            onPressed: () {
                              enterpriseController.plan.value = plan;
                            },
                          );
                        },
                      ),
                    ],
                    if (enterpriseController.status.isEmpty)
                      FidelityEmpty(
                        text: 'Nenhum plano encontrado',
                      ),
                    if (enterpriseController.status.isError)
                      FidelityEmpty(
                        text: enterpriseController.status.errorMessage ?? '500',
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> saveEnterprise(BuildContext context) async {
    if (authController != null && authController?.user.value.enterprise != null) {
      Get.find<AuthController>().user.value.enterprise!.membershipId = enterpriseController.plan.value.id;
      Get.back();
      return;
    }

    enterpriseController.loading.value = true;
    enterpriseController.signupEnterprise.value.membershipId = enterpriseController.plan.value.id;
    enterpriseController.signupEnterprise.value.employeeName = enterpriseController.signupEnterprise.value.name;
    enterpriseController.userSignup.value.enterprise = enterpriseController.signupEnterprise.value;
    await enterpriseController.signup();
    if (enterpriseController.status.isSuccess) {
      enterpriseController.loading.value = false;
      Get.toNamed('/signup/enterprise/success');
      return;
    }
    enterpriseController.loading.value = false;
    _showErrorDialog(context);
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Cadastrar-se como empresa',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          enterpriseController.status.errorMessage ?? 'Erro ao cadastrar',
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

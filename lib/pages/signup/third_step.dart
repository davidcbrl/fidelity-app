import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_plan_card.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class _ThirdStepBodyState extends State<ThirdStepBody> {
  EnterpriseController enterpriseController = Get.find();
  int _index = 0;
  List<bool> _selected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => enterpriseController.loading.value
      ? FidelityLoading(
          loading: enterpriseController.loading.value,
          text: 'Cadastrando-se...',
        )
      : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    FidelityStepper(currentStep: 3),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Quase lá... Escolha um de nossos planos, cada plano possui recursos diferentes, portanto, escolha o plano que for a cara do seu negócio!',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _plansCarousel(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            _navigationButtons(),
          ],
        ),
    );
  }

  Widget _plansCarousel() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return Transform.scale(
            scale: i == _index ? 1 : 0.8,
            child: [
              FidelityPlanCard(
                title: 'Simples',
                value: '100',
                description:
                    'Funcionalidades padrões de gestão de fidelidades, relatórios gerenciais e cadastros limitados.',
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _selected.length; i++) {
                      _selected[i] = i == _index;
                    }
                  });
                },
                selected: _selected[i],
              ),
              FidelityPlanCard(
                title: 'Avançado',
                value: '250',
                description: 'Todas as vantagens do plano Simples + destaque para clientes e cadastros ilimitados.',
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _selected.length; i++) {
                      _selected[i] = i == _index;
                    }
                  });
                },
                selected: _selected[i],
              ),
            ][_index],
          );
        },
      ),
    );
  }

  Widget _navigationButtons() {
    EnterpriseController controller = Get.find();

    return Column(
      children: [
        FidelityButton(
          label: 'Concluir',
          onPressed: () {
            controller.signupEnterprise.value.membershipId = _index + 2;
            saveEnterprise(context);
          },
        ),
        FidelityTextButton(
          label: 'Voltar',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  void saveEnterprise(BuildContext context) async {
    enterpriseController.loading.value = true;
    enterpriseController.userSignup.value.enterprise = enterpriseController.signupEnterprise.value;
    await enterpriseController.signup();
    if (enterpriseController.status.isSuccess) {
      enterpriseController.loading.value = false;
      Get.toNamed('/signup/company/success');
      return;
    }
    enterpriseController.loading.value = false;
    showDialog(
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
    return;
  }
}

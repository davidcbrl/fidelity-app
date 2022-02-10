import 'package:fidelity/pages/signup/sign_up_success.dart';
import 'package:fidelity/widgets/fidelity_plan_card.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdStepBody extends StatefulWidget {
  @override
  _ThirdStepBodyState createState() => _ThirdStepBodyState();
}

class _ThirdStepBodyState extends State<ThirdStepBody> {
  int _index = 0;
  List<bool> _selected = [false, false];

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Cadastro',
            style: Theme.of(context).textTheme.headline1,
          ),
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
            height: 30,
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
                description: 'Funcionalidades padrões de gestão de fidelidades, relatórios gerenciais e cadastros limitados.',
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
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 90,
          child: Column(
            children: [
              FidelityButton(
                label: 'Concluir',
                onPressed: () {
                  Get.to(SignUpSuccessPage(), transition: Transition.rightToLeft);
                },
              ),
              FidelityTextButton(
                label: 'Voltar',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
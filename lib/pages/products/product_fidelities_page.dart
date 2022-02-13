import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductFidelitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Deseja vincular uma fidelidade?',
      ),
      body: ProductFidelitiesBody(),
    );
  }
}

class ProductFidelitiesBody extends StatelessWidget {
  ProductController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Selecione as fidelidades que desejar vincular à este produto ou crie uma nova fidelidade',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FidelityButton(
                label: 'Nova fidelidade',
                onPressed: () {
                  print('CLICOU');
                }
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: List.generate(3, (index) => FidelityLinkItem(
                  id: 1,
                  label: 'Clube de pontos',
                  description: 'Quantidade - Cupom de desconto',
                  selected: index == 0,
                )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        FidelityButton(
          label: 'Concluir',
          onPressed: () {
            print('CLICOU');
          }
        ),
      ],
    );
  }
}
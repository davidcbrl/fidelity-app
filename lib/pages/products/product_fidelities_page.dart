import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/pages/products/product_success.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
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

class ProductFidelitiesBody extends StatefulWidget {
  @override
  _ProductFidelitiesBodyState createState() => _ProductFidelitiesBodyState();
}

class _ProductFidelitiesBodyState extends State<ProductFidelitiesBody> {
  ProductController authController = Get.find();
  List<bool> _fidelities = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
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
                children: List.generate(_fidelities.length, (index) => FidelityLinkItem(
                  id: index + 1,
                  label: 'Clube de pontos',
                  description: 'Quantidade - Cupom de desconto',
                  selected: _fidelities[index],
                  onPressed: () {
                    setState(() {
                      _fidelities[index] = !_fidelities[index];
                    });
                  },
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
            Get.off(() => ProductSuccessPage(), transition: Transition.rightToLeft);
          }
        ),
        FidelityTextButton(
          label: 'Voltar',
          onPressed: () {
            Get.back();
            FocusScope.of(context).unfocus();
          }
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
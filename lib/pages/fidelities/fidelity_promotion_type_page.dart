import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/fidelity_promotion.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityPromotionTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Selecione o tipo de promoção',
      ),
      body: FidelityPromotionTypeBody(),
    );
  }
}

class FidelityPromotionTypeBody extends StatelessWidget {
  FidelityController fidelityController = Get.find();

  List<FidelityPromotion> promotions = [
    FidelityPromotion(
      id: 1,
      name: 'Cupom de desconto',
      description:
          'Ao alcançar a promoção o cliente ganha um cupom de desconto para utilizar posteriormente.\nExemplo: "Cupom de R\$20 de desconto na próxima compra"',
    ),
    FidelityPromotion(
      id: 2,
      name: 'Vale produto',
      description:
          'Ao alcançar a promoção o cliente ganha um vale para utilizar um produto posteriormente.\nExemplo: "Ganhe um dia de SPA"',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'É a forma como o cliente receberá a promoção',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Column(
            children: List.generate(
              promotions.length,
              (index) => FidelitySelectItem(
                id: promotions[index].id,
                label: promotions[index].name ?? '',
                description: promotions[index].description ?? '',
                onPressed: () {
                  selectPromotion(promotions[index]);
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
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

  void selectPromotion(FidelityPromotion promotion) {
    fidelityController.fidelity.value.promotionTypeId = promotion.id;
    if (promotion.id == 1)
      Get.toNamed('/fidelity/promotion');
    else
      Get.toNamed('/fidelity/products');
  }
}

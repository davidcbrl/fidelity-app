import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/fidelity.dart';
import '../../widgets/fidelity_appbar.dart';
import '../../widgets/fidelity_button.dart';
import '../../widgets/fidelity_empty.dart';
import '../../widgets/fidelity_loading.dart';
import '../../widgets/fidelity_select_item.dart';
import '../../widgets/fidelity_text_field.dart';
import '../products/product_add_page.dart';

class FidelityListPage extends StatelessWidget {
  const FidelityListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Fidelidades',
        hasBackButton: false,
      ),
      body: FidelityListBody(),
    );
  }
}

class FidelityListBody extends StatelessWidget {
  FidelityController fidelityController = Get.put(FidelityController());
  TextEditingController _textEditingController = new TextEditingController();
  FidelityListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        FidelityTextField(
          controller: _textEditingController,
          label: 'Filtrar',
          placeholder: 'Nome da fidelidade',
          icon: Icon(Icons.search),
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            Get.to(() => ProductAddPage(), transition: Transition.cupertino);
          },
          label: 'Nova Fidelidade',
        ),
        SizedBox(
          height: 20,
        ),
        _fidelityList(),
      ],
    );
  }

  Widget _fidelityList() {
    return Obx(
      () => fidelityController.loading.value
          ? FidelityLoading(
              loading: fidelityController.loading.value,
              text: 'Carregando fidelidades...',
            )
          : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (fidelityController.status.isSuccess) ...[
                      ...fidelityController.fidelitiesList.map(
                        (Fidelity fidelity) => FidelitySelectItem(
                          id: fidelity.id,
                          label: fidelity.name ?? '',
                          description: fidelity.description ?? '',
                          onPressed: () {},
                        ),
                      ),
                    ],
                    if (fidelityController.status.isEmpty || fidelityController.status.isError) ...[
                      FidelityEmpty(
                        text: 'Nenhum produto encontrado',
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}

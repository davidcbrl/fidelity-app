import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
  ScrollController scrollController = new ScrollController();

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
          onChanged: (value) => fidelityController.filter.value = value,
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            fidelityController.fidelity.value = Fidelity();
            Get.toNamed("/fidelity/add");
          },
          label: 'Nova fidelidade',
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
      () => Expanded(
        child: LazyLoadScrollView(
          isLoading: fidelityController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => fidelityController.getFidelitiesNextPage(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              if (fidelityController.fidelitiesList.isEmpty && fidelityController.status.isError) ...[
                FidelityEmpty(
                  text: 'Nenhuma fidelidade encontrada',
                ),
              ],
              ...fidelityController.fidelitiesList.map(
                (Fidelity fidelity) => FidelitySelectItem(
                  id: fidelity.id,
                  label: fidelity.name ?? '',
                  description: fidelity.description ?? '',
                  onPressed: () {
                    Get.toNamed("/fidelity/add", arguments: fidelity);
                  },
                ),
              ),
              ...[FidelityLoading(loading: fidelityController.loading.value)]
            ],
          ),
        ),
      ),
    );
  }
}

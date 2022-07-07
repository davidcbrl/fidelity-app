import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/pages/enterprises/enterprise_promotions_page.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class EnterpriseListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Promoções',
        hasBackButton: false,
      ),
      body: EnterpriseListBody(),
    );
  }
}

class EnterpriseListBody extends StatefulWidget {
  @override
  State<EnterpriseListBody> createState() => _EnterpriseListBodyState();
}

class _EnterpriseListBodyState extends State<EnterpriseListBody> {
  GetStorage box = GetStorage();
  EnterpriseController enterpriseController = Get.put(EnterpriseController());
  TextEditingController _textEditingController = new TextEditingController();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

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
          placeholder: 'Nome da empresa',
          icon: Icon(Icons.search),
          onChanged: (value) {
            enterpriseController.filter.value = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        _enterprisesList(),
      ],
    );
  }

  Widget _enterprisesList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: enterpriseController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => enterpriseController.getEnterprisesNextPage(),
          child: Container(
            child: RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  if (!enterpriseController.status.isError && enterpriseController.enterprisesList.length > 0) ...[
                    ...enterpriseController.enterprisesList.map(
                      (Enterprise enterprise) => FidelitySelectItem(
                        image: Image.asset(
                          'assets/img/enterprise.png',
                          height: 40,
                          width: 40,
                        ),
                        id: enterprise.id,
                        label: enterprise.name ?? '',
                        onPressed: () {
                          box.write('enterpriseId', enterprise.id);
                          Get.to(() => EnterprisePromotionsPage(enterprise: enterprise));
                        },
                      ),
                    ),
                  ],
                  if (enterpriseController.status.isLoading)
                    FidelityLoading(
                      loading: enterpriseController.loading.value,
                      text: 'Carregando empresas...',
                    ),
                  if (enterpriseController.status.isEmpty)
                    FidelityEmpty(
                      text: 'Nenhuma empresa encontrada',
                    ),
                  if (enterpriseController.status.isError)
                    FidelityEmpty(
                      text: enterpriseController.status.errorMessage ?? '500',
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    enterpriseController.page.value = 1;
    await enterpriseController.getEnterprises();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
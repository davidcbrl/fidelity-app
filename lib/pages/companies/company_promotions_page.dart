import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_company_header.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CompanyPromotionsPage extends StatelessWidget {
  Enterprise? company;

  CompanyPromotionsPage({this.company});

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Promoções da empresa',
      ),
      body: CompanyPromotionsBody(company: company ?? Enterprise()),
    );
  }
}

class CompanyPromotionsBody extends StatefulWidget {
  Enterprise company;

  CompanyPromotionsBody({required this.company});

  @override
  State<CompanyPromotionsBody> createState() => _CompanyPromotionsBodyState();
}

class _CompanyPromotionsBodyState extends State<CompanyPromotionsBody> {
  FidelityController fidelityController = Get.put(FidelityController());
  ScrollController scrollController = new ScrollController();

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
        FidelityCompanyHeader(
          company: widget.company,
        ),
        SizedBox(
          height: 20,
        ),
        _promotionsList(),
      ],
    );
  }

  Widget _promotionsList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: fidelityController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => fidelityController.getFidelitiesNextPage(),
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
                      return FidelitySelectItem(
                        id: fidelity.id,
                        label: fidelity.name ?? '',
                        description: fidelity.description ?? '',
                        onPressed: () {
                          print('CLICOU');
                        },
                      );
                    },
                  ),
                ],
                if (fidelityController.status.isLoading)... [
                  FidelityLoading(
                    loading: fidelityController.loading.value,
                    text: 'Carregando promoções...',
                  ),
                ],
                if (fidelityController.status.isEmpty)... [
                  FidelityEmpty(
                    text: 'Nenhuma promoção encontrada',
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
    );
  }

  Future<void> _refresh() async {
    fidelityController.page.value = 1;
    await fidelityController.getFidelities();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
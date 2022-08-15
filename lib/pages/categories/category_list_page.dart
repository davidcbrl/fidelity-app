import 'package:fidelity/controllers/category_controller.dart';
import 'package:fidelity/models/category.dart';
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

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Categorias',
      ),
      body: CategoryListBody(),
    );
  }
}

class CategoryListBody extends StatefulWidget {
  @override
  State<CategoryListBody> createState() => _CategoryListBodyState();
}

class _CategoryListBodyState extends State<CategoryListBody> {
  CategoryController categoryController = Get.put(CategoryController());
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
          placeholder: 'Nome da categoria',
          icon: Icon(Icons.search),
          onChanged: (value) {
            categoryController.filter.value = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            categoryController.category.value = Category();
            Get.toNamed('/category/add');
          },
          label: 'Nova categoria',
        ),
        SizedBox(
          height: 20,
        ),
        _categorysList(),
      ],
    );
  }

  Widget _categorysList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: categoryController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => categoryController.getCategoriesNextPage(),
          child: Obx(
            () => RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  if (!categoryController.status.isError && categoryController.categoriesList.length > 0)... [
                    ...categoryController.categoriesList.map(
                      (Category category) => FidelitySelectItem(
                        id: category.id,
                        label: category.name ?? '',
                        onPressed: () {
                          categoryController.category.value = category;
                          Get.toNamed('/category/add');
                        },
                      ),
                    ),
                  ],
                  if (categoryController.status.isLoading)
                    FidelityLoading(
                      loading: categoryController.loading.value,
                      text: 'Carregando categories...',
                    ),
                  if (categoryController.status.isEmpty)
                    FidelityEmpty(
                      text: 'Nenhuma categoria encontrada',
                    ),
                  if (categoryController.status.isError)
                    FidelityEmpty(
                      text: categoryController.status.errorMessage ?? '500',
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
    categoryController.page.value = 1;
    await categoryController.getCategories();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}

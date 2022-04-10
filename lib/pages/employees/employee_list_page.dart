import 'dart:convert';

import 'package:fidelity/controllers/employee_controller.dart';
import 'package:fidelity/models/user.dart';
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

class EmployeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Funcionários',
        hasBackButton: false,
      ),
      body: EmployeeListBody(),
    );
  }
}

class EmployeeListBody extends StatefulWidget {
  @override
  State<EmployeeListBody> createState() => _EmployeeListBodyState();
}

class _EmployeeListBodyState extends State<EmployeeListBody> {
  EmployeeController employeeController = Get.put(EmployeeController());
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
          placeholder: 'Nome do funcionário',
          icon: Icon(Icons.search),
          onChanged: (value) {
            employeeController.filter.value = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            employeeController.employee.value = User();
            Get.toNamed('/employee/add');
          },
          label: 'Novo funcionário',
        ),
        SizedBox(
          height: 20,
        ),
        _employeesList(),
      ],
    );
  }

  Widget _employeesList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: employeeController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => employeeController.getEmployeesNextPage(),
          child: Obx(
            () => RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  if (!employeeController.status.isError && employeeController.employeesList.length > 0)... [
                    ...employeeController.employeesList.map(
                      (User employee) => FidelitySelectItem(
                        id: employee.id,
                        label: employee.name ?? '',
                        image: employee.photo != null
                          ? Image.memory(
                              base64Decode(employee.photo ?? ''),
                              height: 50,
                              width: 50,
                            )
                          : Image.asset(
                              'assets/img/user.jpg',
                              height: 50,
                              width: 50,
                            ),
                        onPressed: () {
                          employeeController.employee.value = employee;
                          Get.toNamed('/employee/add');
                        },
                      ),
                    ),
                  ],
                  if (employeeController.status.isLoading)
                    FidelityLoading(
                      loading: employeeController.loading.value,
                      text: 'Carregando funcionários...',
                    ),
                  if (employeeController.status.isEmpty)
                    FidelityEmpty(
                      text: 'Nenhum funcionário encontrado',
                    ),
                  if (employeeController.status.isError)
                    FidelityEmpty(
                      text: employeeController.status.errorMessage ?? '500',
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
    employeeController.page.value = 1;
    await employeeController.getEmployees();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}

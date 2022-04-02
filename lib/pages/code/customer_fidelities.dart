import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerFidelitiesPage extends StatelessWidget {
  const CustomerFidelitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Progresso do cliente',
      ),
      body: Container(height: Get.height, child: CustomerFidelitiesBody()),
    );
  }
}

class CustomerFidelitiesBody extends StatelessWidget {
  const CustomerFidelitiesBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();

    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                ),
                child: Image.asset(
                  'assets/img/company.png',
                  width: 50,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    box.hasData('user') ? box.read('user') : 'Luke Skywalker',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Cliente desde 2020',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Center(
            child: Text("Selecione a fidelidade para atualizar"),
          )
        ],
      ),
    );
  }
}

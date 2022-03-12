import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/fidelity_appbar.dart';

class FidelityConditionTypePage extends StatelessWidget {
  const FidelityConditionTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Selecione o tipo de fidelizacão',
        hasBackButton: false,
      ),
      body: FidelityConditionTypeBody(),
    );
  }
}

class FidelityConditionTypeBody extends StatelessWidget {
  const FidelityConditionTypeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Selecione as fidelidades que desejar vincular à este produto ou crie uma nova fidelidade',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

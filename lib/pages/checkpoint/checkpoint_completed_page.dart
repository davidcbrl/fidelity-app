import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckpointCompletedPage extends StatelessWidget {
  final List<Checkpoint>? completedCheckpoints;

  CheckpointCompletedPage({
    this.completedCheckpoints,
  });

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: CheckpointCompletedBody(completedCheckpoints: completedCheckpoints),
    );
  }
}

class CheckpointCompletedBody extends StatelessWidget {
  final List<Checkpoint>? completedCheckpoints;

  CheckpointCompletedBody({
    this.completedCheckpoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/completed.gif',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Fidelidade completa!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Este cliente já pode receber as promoções das seguintes fidelidades:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        ...List.generate(completedCheckpoints!.length, (index) {
          return Text(
            'ID: ' + completedCheckpoints![index].fidelityId.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          );
        }).toList(),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          label: 'Voltar para checkpoint',
          onPressed: () {
            Get.off(() => HomePage(pageIndex: 2), transition: Transition.cupertino);
          },
        ),
      ],
    );
  }
}
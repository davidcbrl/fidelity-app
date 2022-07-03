import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:flutter/material.dart';

class FidelitySuccess extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final Function() onPressed;
  final String? imagePath;

  FidelitySuccess({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath ?? 'assets/img/ok.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          label: buttonText,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
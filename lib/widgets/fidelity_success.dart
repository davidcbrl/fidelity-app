import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:flutter/material.dart';

class FidelitySuccess extends StatefulWidget {
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
  _FidelitySuccessState createState() => _FidelitySuccessState();
}

class _FidelitySuccessState extends State<FidelitySuccess> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          widget.imagePath ?? 'assets/img/ok.png',
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          label: widget.buttonText,
          onPressed: widget.onPressed,
        ),
      ],
    );
  }
}
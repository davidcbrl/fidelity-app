import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:flutter/material.dart';

class FidelitySuccess extends StatefulWidget {
  final String title;
  final String description;
  final String buttonText;
  final Function() onPressed;

  FidelitySuccess(
    this.title,
    this.description,
    this.buttonText,
    this.onPressed,
  );

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
        Icon(
          Icons.check_circle,
          size: 100,
          color: Theme.of(context).colorScheme.secondary,
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
          widget.buttonText,
          widget.onPressed,
        ),
      ],
    );
  }
}
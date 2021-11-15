import 'package:flutter/material.dart';

class FidelityTextButton extends StatefulWidget {
  final String label;
  final Function() onPressed;

  FidelityTextButton(
    this.label,
    this.onPressed,
  );

  @override
  _FidelityTextButtonState createState() => _FidelityTextButtonState();
}

class _FidelityTextButtonState extends State<FidelityTextButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
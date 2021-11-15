import 'package:flutter/material.dart';

class FidelityButton extends StatefulWidget {
  final String label;
  final Function() onPressed;

  FidelityButton(
    this.label,
    this.onPressed,
  );

  @override
  _FidelityButtonState createState() => _FidelityButtonState();
}

class _FidelityButtonState extends State<FidelityButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
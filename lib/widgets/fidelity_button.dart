import 'package:flutter/material.dart';

class FidelityButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;

  FidelityButton({
    required this.label,
    required this.onPressed,
    this.width = double.infinity
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

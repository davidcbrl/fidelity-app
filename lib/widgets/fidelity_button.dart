import 'package:flutter/material.dart';

class FidelityButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  FidelityButton({
    required this.label,
    required this.onPressed,
  });

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
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

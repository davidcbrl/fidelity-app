import 'package:flutter/material.dart';

class FidelityButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  final TextAlign? labelAlignment;

  FidelityButton({
    required this.label,
    required this.onPressed,
    this.width = double.infinity,
    this.labelAlignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: labelAlignment ?? TextAlign.start,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FidelityTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Icon icon;
  final bool hideText;

  FidelityTextField({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: hideText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        labelText: label,
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}

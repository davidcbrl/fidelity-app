import 'package:flutter/material.dart';

class FidelityTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Icon icon;
  final bool hideText;
  final dynamic onChanged;

  FidelityTextField({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.hideText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.labelMedium,
      obscureText: hideText,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        labelText: label,
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: icon,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}

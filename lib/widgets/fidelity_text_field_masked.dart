import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FidelityTextFieldMasked extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Icon icon;
  final bool hideText;
  final String? mask;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool? readOnly;
  final dynamic onTap;

  FidelityTextFieldMasked({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.onChanged,
    this.hideText = false,
    this.validator,
    this.mask,
    this.onTap,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      onTap: onTap,
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: hideText,
      inputFormatters: [MaskTextInputFormatter(mask: mask ?? '')],
      validator: validator,
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

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

  FidelityTextFieldMasked({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.onChanged,
    this.hideText = false,
    this.validator,
    this.mask,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: widget.hideText,
      inputFormatters: [MaskTextInputFormatter(mask: widget.mask ?? '')],
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeholder,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        suffixIcon: widget.icon,
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

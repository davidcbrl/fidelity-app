import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FidelityTextFieldMasked extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Icon icon;
  final bool hideText;
  final MaskTextInputFormatter? formatter;
  final FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  FidelityTextFieldMasked(
    this.controller,
    this.label,
    this.placeholder,
    this.icon, {
    this.onChanged,
    this.hideText = false,
    this.validator,
    this.formatter,
  });

  @override
  _FidelityTextFieldMaskedState createState() => _FidelityTextFieldMaskedState();
}

class _FidelityTextFieldMaskedState extends State<FidelityTextFieldMasked> {
  @override
  Widget build(BuildContext context) {
    var informatter;
    if (widget.formatter != null) informatter = widget.formatter!;
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: widget.hideText,
      inputFormatters: [informatter],
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeholder,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        filled: true,
        fillColor: Theme.of(context).accentColor,
        suffixIcon: widget.icon,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

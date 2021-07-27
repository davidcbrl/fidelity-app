import 'package:flutter/material.dart';

class FidelityTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Icon icon;
  final bool hideText;

  FidelityTextField(
    this.controller,
    this.label,
    this.placeholder,
    this.icon,
    {this.hideText = false}
  );

  @override
  _FidelityTextFieldState createState() => _FidelityTextFieldState();
}

class _FidelityTextFieldState extends State<FidelityTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: widget.hideText,
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
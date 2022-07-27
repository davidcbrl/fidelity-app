import 'package:flutter/material.dart';

class FidelityResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  FidelityResponsiveLayout({
    required this.mobile,
    required this.desktop
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return this.mobile;
        }
        return this.desktop;
      },
    );
  }
}
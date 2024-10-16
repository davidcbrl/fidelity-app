import 'package:flutter/material.dart';

class FidelityPage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomBar;
  final bool hasPadding;

  FidelityPage({
    this.appBar,
    this.body,
    this.bottomBar,
    this.hasPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: hasPadding ? EdgeInsets.symmetric(horizontal: 15) : EdgeInsets.zero,
        child: body,
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

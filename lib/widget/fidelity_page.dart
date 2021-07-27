import 'package:flutter/material.dart';

class FidelityPage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final bool hasPadding;

  FidelityPage({this.appBar, this.body, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: hasPadding ? EdgeInsets.all(20) : EdgeInsets.zero,
        child: body,
      ),
    );
  }
}
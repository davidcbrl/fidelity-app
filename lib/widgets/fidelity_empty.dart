import 'package:flutter/material.dart';

class FidelityEmpty extends StatelessWidget {
  final String text;
  final double? iconSize;

  const FidelityEmpty({
    required this.text,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/empty.png',
          height: iconSize ?? 200,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

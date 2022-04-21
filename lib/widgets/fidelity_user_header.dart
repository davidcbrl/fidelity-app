import 'package:flutter/material.dart';

class FidelityUserHeader extends StatelessWidget {
  String imagePath;
  String name;
  String description;
  double? imageBorderRadius;

  FidelityUserHeader({
    required this.imagePath,
    required this.name,
    required this.description,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(imageBorderRadius ?? 5),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          child: Image.asset(
            imagePath,
            width: 50,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
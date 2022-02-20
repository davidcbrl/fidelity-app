import 'package:flutter/material.dart';

class FidelitySelectItem extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final String? description;

  FidelitySelectItem({
    required this.label,
    required this.onPressed,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      if (description != null) ...[
                        Text(
                          description ?? '',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ]
                    ],
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
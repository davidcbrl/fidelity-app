import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityLinkItem extends StatelessWidget {
  final int id;
  final String label;
  final Function() onPressed;
  final String? description;
  final bool selected;

  FidelityLinkItem({
    required this.id,
    required this.label,
    required this.onPressed,
    this.description,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
            ),
          ),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        id.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          if (description != null)
                            Container(
                              width: Get.width - 150,
                              child: Text(
                                description ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Checkbox(
                    value: selected,
                    onChanged: (value) {
                      onPressed();
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

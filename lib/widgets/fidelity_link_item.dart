import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityLinkItem extends StatelessWidget {
  final int? id;
  final String label;
  final Function() onPressed;
  final String? description;
  final bool selected;
  final bool active;

  FidelityLinkItem({
    this.id,
    required this.label,
    required this.onPressed,
    this.description,
    this.selected = false,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: active ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surface,
            border: Border.all(
              width: active ? 2 : 4,
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
                      if (id != null) ...[
                        Text(
                          id.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width - Get.width * 0.5,
                            child: Text(
                              '${active ? "" : "(inativo) "}' + label,
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (description != null) ...[
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: Get.width - Get.width * 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      description ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

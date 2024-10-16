import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelitySelectItem extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final String? description;
  final int? id;
  final Widget? image;
  final IconData? icon;
  final bool active;

  FidelitySelectItem({
    required this.label,
    required this.onPressed,
    this.description,
    this.id,
    this.image,
    this.icon,
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
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (image != null) ...[
                        image ?? Container(),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                      if (id != null) ...[
                        Text(
                          id.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (icon != null) ...[
                                Icon(
                                  icon,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                              Container(
                                width: Get.width - Get.width * 0.6,
                                child: Text(
                                  '${active ? "" : "(inativo) "}' + label,
                                  style: Theme.of(context).textTheme.labelMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (description != null) ...[
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: Get.width - Get.width * 0.4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      description ?? '',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
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
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
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

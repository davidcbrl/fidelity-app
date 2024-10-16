import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityProgressItem extends StatelessWidget {
  final String label;
  final String description;
  final int typeId;
  final double progress;
  final double target;
  final Function() onPressed;
  final bool icon;

  FidelityProgressItem({
    required this.label,
    required this.description,
    required this.typeId,
    required this.progress,
    required this.target,
    required this.onPressed,
    this.icon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surface,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width - Get.width * 0.4,
                            child: Text(
                              label,
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.width - Get.width * 0.4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    description,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.width - Get.width * 0.4,
                            child: Row(
                              children: [
                                Text(
                                  '${progress.toInt()}/${target.toInt()}',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                if (typeId == 1) ...[
                                  Container(
                                    width: Get.width - Get.width * 0.5,
                                    child: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          target.toInt(),
                                          (index) => Icon(
                                            Icons.circle,
                                            color: progress.toInt() > index ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiaryContainer,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (typeId != 1) ...[
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: progress/target,
                                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (icon)
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityProgressItem extends StatelessWidget {
  final String label;
  final String description;
  final double progress;
  final double target;
  final Function() onPressed;

  FidelityProgressItem({
    required this.label,
    required this.description,
    required this.progress,
    required this.target,
    required this.onPressed,
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
              color: Theme.of(context).colorScheme.surface,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.width - Get.width * 0.5,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    description,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                '${progress.toInt()}/${target.toInt()}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ...List.generate(
                                progress.toInt(),
                                (index) => Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              ...List.generate(
                                target.toInt(),
                                (index) => Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: Color(0xFFBDBDBD),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Theme.of(context).colorScheme.secondaryContainer,
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

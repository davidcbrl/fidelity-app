import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityItemDash extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final String? description;
  final String? valueNumber;
  final int? id;
  final Widget? image;
  final IconData? icon;
  final bool active;

  FidelityItemDash({
    required this.label,
    required this.onPressed,
    this.description,
    this.valueNumber,
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
            color: Theme.of(context).colorScheme.surface,
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
                          style: Theme.of(context).textTheme.bodyText1,
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
                                  size: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                              SizedBox(width: 10,),
                              Container(
                                width: Get.width - Get.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        description ?? '',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                valueNumber!,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
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

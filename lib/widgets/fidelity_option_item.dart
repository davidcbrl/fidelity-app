import 'package:flutter/material.dart';

class FidelityOptionItem extends StatelessWidget {
  final String label;
  final Function() onPressed;
  String? selectedLabel;

  FidelityOptionItem({
    required this.label,
    required this.onPressed,
    this.selectedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: selectedLabel == null ? 1 : 2,
          color: selectedLabel == null ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                if (selectedLabel != null) ...[
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
                Text(
                  selectedLabel ?? label,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Icon(
              Icons.list_outlined,
              color: selectedLabel == null ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FidelityOptionItem extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final String? selectedLabel;

  FidelityOptionItem({
    required this.label,
    required this.onPressed,
    this.selectedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: selectedLabel == null ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.primary,
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
                Text(
                  selectedLabel ?? label,
                  style: Theme.of(context).textTheme.labelMedium,
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

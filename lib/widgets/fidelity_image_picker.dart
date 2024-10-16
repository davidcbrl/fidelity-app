import 'package:flutter/material.dart';

class FidelityImagePicker extends StatelessWidget {
  final dynamic image;
  final String label;
  final String emptyImagePath;
  final Function() onSelect;
  final double? size;

  FidelityImagePicker({
    this.image,
    required this.label,
    required this.emptyImagePath,
    required this.onSelect,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size != null ? size! + (size! * 0.25) : null,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: image == null ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.primary,
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (image != null)
                  Container(
                    height: size ?? 50,
                    width: size ?? 50,
                    child: Image.memory(image),
                  ),
                if (image == null)
                  Container(
                    height: size ?? 50,
                    width: size ?? 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      emptyImagePath,
                      height: size ?? 50,
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            Icon(
              Icons.image_outlined,
              color: image == null ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

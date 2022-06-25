import 'package:flutter/material.dart';

class FidelityImagePicker extends StatelessWidget {
  var image;
  final String label;
  final String emptyImagePath;
  final Function() onSelect;
  final double? size;

  FidelityImagePicker(
      {this.image, required this.label, required this.emptyImagePath, required this.onSelect, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size != null ? size! + (size! * 0.25) : null,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: image == null ? 1 : 2,
          color: image == null ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
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
                    height: size,
                    width: size,
                    child: Image.memory(image),
                  ),
                if (image == null)
                  Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      emptyImagePath,
                      height: size,
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText1,
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

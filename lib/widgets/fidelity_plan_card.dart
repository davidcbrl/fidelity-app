import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:flutter/material.dart';

class FidelityPlanCard extends StatefulWidget {
  final String title;
  final String value;
  final String description;
  final Function() onPressed;
  final bool selected;

  FidelityPlanCard({
    required this.title,
    required this.value,
    required this.description,
    required this.onPressed,
    this.selected = false
  });

  @override
  _FidelityPlanCardState createState() => _FidelityPlanCardState();
}

class _FidelityPlanCardState extends State<FidelityPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: widget.selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  children: [
                    Text(
                      'R\$',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      widget.value,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      '/mes',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            FidelityButton(
              label: 'Escolher',
              onPressed: widget.onPressed
            ),
          ],
        ),
      ),
    );
  }
}
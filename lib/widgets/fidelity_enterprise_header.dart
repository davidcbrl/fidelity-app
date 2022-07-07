import 'package:fidelity/models/enterprise.dart';
import 'package:flutter/material.dart';

class FidelityEnterpriseHeader extends StatelessWidget {
  Enterprise enterprise;

  FidelityEnterpriseHeader({
    required this.enterprise,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          child: Image.asset(
            'assets/img/enterprise.png',
            width: 100,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              enterprise.name ?? '',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              enterprise.branch ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${enterprise.address}, ${enterprise.addressNum} - ${enterprise.city}, ${enterprise.state}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              enterprise.tel ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
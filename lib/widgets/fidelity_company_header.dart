import 'package:fidelity/models/enterprise.dart';
import 'package:flutter/material.dart';

class FidelityCompanyHeader extends StatelessWidget {
  Enterprise company;

  FidelityCompanyHeader({
    required this.company,
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
            'assets/img/company.png',
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
              company.name ?? '',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              company.branch ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${company.adress}, ${company.adressNum} - ${company.city}, ${company.state}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              company.tel ?? '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
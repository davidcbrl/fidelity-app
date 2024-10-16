import 'dart:convert';

import 'package:fidelity/models/enterprise.dart';
import 'package:flutter/material.dart';

class FidelityEnterpriseHeader extends StatelessWidget {
  final Enterprise enterprise;

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
          ),
          child: enterprise.image != null
            ? Image.memory(
                base64Decode(enterprise.image ?? ''),
                width: 100,
                height: 100,
              )
            : Image.asset(
                'assets/img/enterprise.png',
                width: 100,
                height: 100,
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
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              enterprise.branch ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${enterprise.address}, ${enterprise.addressNum} - ${enterprise.city}, ${enterprise.state}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              enterprise.tel ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
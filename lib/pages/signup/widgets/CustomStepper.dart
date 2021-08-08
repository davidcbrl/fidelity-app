import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  CustomStepper(this.currentStep);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Empresa",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: 100,
              ),
              Text(
                "Acesso",
                style: TextStyle(
                  color: currentStep >= 1 ? Theme.of(context).primaryColor : Color(0xFFBDBDBD),
                ),
              ),
              SizedBox(
                width: 110,
              ),
              Text(
                "Plano",
                style: TextStyle(
                  color: currentStep == 2 ? Theme.of(context).primaryColor : Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Image.asset(
                currentStep == 0 ? "assets/img/lineCircleBlue.png" : "assets/img/checkedBlueCircle.png",
                width: 25,
              ),
              Container(
                height: 10,
                width: 130,
                color: currentStep > 0 ? Colors.blueAccent : Color(0xFFE0E0E0),
              ),
              if (currentStep == 0)
                Image.asset(
                  "assets/img/lineCircleGrey.png",
                  width: 25,
                ),
              if (currentStep > 0)
                Image.asset(
                  currentStep > 1 ? "assets/img/checkedBlueCircle.png" : "assets/img/lineCircleBlue.png",
                  width: 25,
                ),
              Container(
                height: 10,
                width: 125,
                color: currentStep > 1 ? Colors.blueAccent : Color(0xFFE0E0E0),
              ),
              Image.asset(
                currentStep >= 2 ? "assets/img/lineCircleBlue.png" : "assets/img/lineCircleGrey.png",
                width: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

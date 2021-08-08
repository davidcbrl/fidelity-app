import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityStepper extends StatefulWidget {
  final int currentStep;

  FidelityStepper(this.currentStep);

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<FidelityStepper> {
  var screenHeight = Get.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  color: widget.currentStep >= 1 ? Theme.of(context).primaryColor : Color(0xFFBDBDBD),
                ),
              ),
              SizedBox(
                width: 110,
              ),
              Text(
                "Plano",
                style: TextStyle(
                  color: widget.currentStep == 2 ? Theme.of(context).primaryColor : Color(0xFFBDBDBD),
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
                widget.currentStep == 0 ? "assets/img/lineCircleBlue.png" : "assets/img/checkedBlueCircle.png",
                width: 25,
              ),
              Container(
                height: 10,
                width: 130,
                color: widget.currentStep > 0 ? Colors.blueAccent : Color(0xFFE0E0E0),
              ),
              if (widget.currentStep == 0)
                Image.asset(
                  "assets/img/lineCircleGrey.png",
                  width: 25,
                ),
              if (widget.currentStep > 0)
                Image.asset(
                  widget.currentStep > 1 ? "assets/img/checkedBlueCircle.png" : "assets/img/lineCircleBlue.png",
                  width: 25,
                ),
              Container(
                height: 10,
                width: 125,
                color: widget.currentStep > 1 ? Colors.blueAccent : Color(0xFFE0E0E0),
              ),
              Image.asset(
                widget.currentStep >= 2 ? "assets/img/lineCircleBlue.png" : "assets/img/lineCircleGrey.png",
                width: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

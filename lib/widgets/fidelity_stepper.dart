import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FidelityStepper extends StatefulWidget {
  final int currentStep;

  FidelityStepper({required this.currentStep});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<FidelityStepper> with TickerProviderStateMixin {
  var screenHeight = Get.height;
  var screenWidth = Get.width;
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Empresa",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Spacer(),
              Text(
                "Acesso",
                style: TextStyle(
                  color: widget.currentStep >= 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
              Spacer(),
              Text(
                "Plano",
                style: TextStyle(
                  color: widget.currentStep == 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  LinearPercentIndicator(
                    lineHeight: 10.0,
                    percent: widget.currentStep > 0
                        ? widget.currentStep > 1
                            ? 1.0
                            : 0.5
                        : 0.0,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(
                      widget.currentStep == 0 ? "assets/img/lineCircleBlue.png" : "assets/img/checkedBlueCircle.png",
                      width: 25,
                    ),
                  ),
                  Spacer(),
                  if (widget.currentStep == 0)
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Image.asset(
                        "assets/img/lineCircleGrey.png",
                        width: 25,
                      ),
                    ),
                  if (widget.currentStep > 0)
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Image.asset(
                        widget.currentStep > 1 ? "assets/img/checkedBlueCircle.png" : "assets/img/lineCircleBlue.png",
                        width: 25,
                      ),
                    ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(
                      widget.currentStep >= 2 ? "assets/img/lineCircleBlue.png" : "assets/img/lineCircleGrey.png",
                      width: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  setSizeWidth(double number) {
    double size = Get.width / 100;
    return number * size;
  }

  setSizeHeight(double number) {
    double size = Get.height / 100;
    return number * size;
  }
}

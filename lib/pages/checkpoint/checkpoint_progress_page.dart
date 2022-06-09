import 'package:fidelity/models/customer_progress.dart';
import 'package:fidelity/util/fidelity_utils.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckpointProgressPage extends StatelessWidget {
  CustomerProgress? progress;

  CheckpointProgressPage({this.progress});

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Atualizar progresso',
      ),
      body: CheckpointProgressBody(progress: progress ?? CustomerProgress()),
    );
  }
}

class CheckpointProgressBody extends StatefulWidget {
  CustomerProgress progress;

  CheckpointProgressBody({required this.progress});

  @override
  State<CheckpointProgressBody> createState() => _CheckpointProgressBodyState();
}

class _CheckpointProgressBodyState extends State<CheckpointProgressBody> {
  TextEditingController linearController = TextEditingController(text: '');
  double originalScore = 0;

  @override
  void initState() {
    originalScore = widget.progress.score ?? 0;
    if (widget.progress.fidelity!.fidelityTypeId != 1) {
      widget.progress.score = widget.progress.score! / widget.progress.fidelity!.quantity!.toInt();
      linearController.text = widget.progress.score.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Defina o progresso que o cliente está alcançando com essa fidelidade',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              if (widget.progress.fidelity!.fidelityTypeId != 1) ...[
                FidelityTextFieldMasked(
                  controller: linearController,
                  label: "Progresso",
                  placeholder: "0.0",
                  icon: Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo vazio';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      setState(() {
                        widget.progress.score = 0.0;
                      });
                    }
                    if (double.parse(value) > 0) {
                      setState(() {
                        widget.progress.score = double.parse(value);
                      });
                    }
                    setState(() {
                      widget.progress.score = 0.0;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
              _progressCard(context),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        FidelityButton(
          label: 'Salvar progresso e voltar',
          onPressed: () {
            Get.back();
          },
        ),
        FidelityTextButton(
          label: 'Cancelar',
          onPressed: () {
            widget.progress.score = originalScore;
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _progressCard(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            widget.progress.fidelity!.id.toString() + ' ' + widget.progress.fidelity!.name.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Fidelização: ' + FidelityUtils.types[widget.progress.fidelity!.fidelityTypeId ?? 0],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Promoção: ' + FidelityUtils.promotions[widget.progress.fidelity!.promotionTypeId ?? 0],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Vigência: ' + _buildValidityDescription(widget.progress),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20,
          ),
          if (widget.progress.fidelity!.fidelityTypeId == 1)
            Text(
              widget.progress.score!.toInt().toString() + '/' + widget.progress.fidelity!.quantity!.toInt().toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
          if (widget.progress.fidelity!.fidelityTypeId != 1)
            Text(
              widget.progress.score!.toInt().toString() + '/' + widget.progress.fidelity!.quantity!.toInt().toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
          SizedBox(
            height: 20,
          ),
          if (widget.progress.fidelity!.fidelityTypeId == 1)
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                ...List.generate(widget.progress.fidelity!.quantity!.toInt(), (index) {
                  index = index + 1;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.progress.score == index.toDouble()) {
                          widget.progress.score = 0;
                          return;
                        }
                        widget.progress.score = index.toDouble();
                      });
                    },
                    child: Icon(
                      widget.progress.score! < index ? Icons.circle : Icons.check_circle_rounded,
                      color: widget.progress.score! < index ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.secondary,
                      size: 50,
                    ),
                  );
                }).toList(),
              ],
            ),
          if (widget.progress.fidelity!.fidelityTypeId != 1)
            Container(
              width: Get.width,
              child: Expanded(
                child: LinearProgressIndicator(
                  value: widget.progress.score! / widget.progress.fidelity!.quantity!.toDouble(),
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  minHeight: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _buildValidityDescription(CustomerProgress progress) {
    String validity = 'N/A';
    if (progress.fidelity!.startDate != null || progress.fidelity!.endDate != null) {
      DateTime startDate = DateTime.parse(progress.fidelity!.startDate ?? '');
      DateTime endDate = DateTime.parse(progress.fidelity!.endDate ?? '');
      validity = DateFormat('dd/MM/yyyy').format(startDate) + ' - ' + DateFormat('dd/MM/yyyy').format(endDate);
    }
    return validity;
  }
}
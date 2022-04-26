import 'package:fidelity/models/customer_progress.dart';
import 'package:fidelity/util/fidelity_utils.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerProgressPage extends StatelessWidget {
  CustomerProgress? progress;

  CustomerProgressPage({this.progress});

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Atualizar progresso',
      ),
      body: CustomerProgressBody(progress: progress ?? CustomerProgress()),
    );
  }
}

class CustomerProgressBody extends StatefulWidget {
  CustomerProgress progress;

  CustomerProgressBody({required this.progress});

  @override
  State<CustomerProgressBody> createState() => _CustomerProgressBodyState();
}

class _CustomerProgressBodyState extends State<CustomerProgressBody> {
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
                'Selecione o progresso que o cliente está alcançando com essa fidelidade',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: Get.height - Get.height * 0.7,
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
                      height: 5,
                    ),
                    Text(
                      widget.progress.score!.toInt().toString() + '/' + widget.progress.fidelity!.quantity!.toInt().toString(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
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
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        FidelityButton(
          label: 'Salvar e voltar',
          onPressed: () {
          },
        ),
        FidelityTextButton(
          label: 'Cancelar',
          onPressed: () {
            Get.back();
          },
        ),
      ],
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
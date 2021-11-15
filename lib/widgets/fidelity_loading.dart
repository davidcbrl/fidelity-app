import 'package:flutter/material.dart';

class FidelityLoading extends StatefulWidget {
  final bool loading;
  final String text;

  const FidelityLoading(this.loading, {this.text = ''});

  @override
  _FidelityLoadingState createState() => _FidelityLoadingState();
}

class _FidelityLoadingState extends State<FidelityLoading> {
  @override
  Widget build(BuildContext context) {
    return (widget.loading)
      ? Container(
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(),
                ),
              ),
              if (widget.text != '')
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
            ],
          ),
        )
      : Container();
  }
}
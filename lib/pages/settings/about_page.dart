import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
        appBar: FidelityAppbarWidget(
          title: 'Sobre',
        ),
        body: AboutBody());
  }
}

class AboutBody extends StatelessWidget {
  const AboutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Time incrível que fez esse TCC acontecer'),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/rhonner.png',
                          height: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/img/david.png',
                          height: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/img/daniel.png',
                          height: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/gustavo.png',
                          height: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/img/lucas.png',
                          height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Universidade Federal do Paraná"),
                Text("Tecnologia em Análise e Desenvolvimento de Sistemas"),
                SizedBox(
                  height: 30,
                ),
                Text(DateTime.now().year.toString()),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

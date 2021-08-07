import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/img/fidelidadeText.png",
              width: 120,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Empresa",
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Text("Acesso"),
                      SizedBox(
                        width: 100,
                      ),
                      Text("Plano"),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        "assets/img/lineCircle.png",
                        width: 18,
                      ),
                      Container(
                        height: 10,
                        width: 120,
                        color: Colors.black,
                      ),
                      Image.asset(
                        "assets/img/lineCircle.png",
                        width: 18,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

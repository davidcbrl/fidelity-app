import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 80,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Color(0xFF2167E8),
                    ),
                  ),
                  hintText: 'skywalker@jedi.com',
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                  labelText: 'E-mail',
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  hintText: '*****',
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                  labelText: 'Senha',
                  suffixIcon: Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Color(0xFF2167E8),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xFFE0E0E0),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(
                            'Lembrar usuário e senha',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1!
                                    .color),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF2167E8),
                      ),),
                      onPressed: () {},
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Não possui conta? Cadastre-se',
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1!
                            .color),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

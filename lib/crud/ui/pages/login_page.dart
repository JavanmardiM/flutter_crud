import 'package:flutter/material.dart';
import 'package:fluttercrud/crud/ui/widgets/userNameInput.dart';
import 'package:fluttercrud/crud/ui/widgets/PasswordInput.dart';
import 'package:fluttercrud/crud/ui/widgets/Button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Center(
              child : Column(
                children: <Widget>[
                  Row(children: <Widget>[
                  ]),
                  UserNameInput(),
                  PasswordInput(),
                  ButtonLogin(),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

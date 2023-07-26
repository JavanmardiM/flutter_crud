import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/localization/lz.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5.0),
            ),
            labelText: translate(Lz.Login_Page_Password_Text_Label),
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/localization/lz.dart';

class UserNameInput extends StatefulWidget {
  @override
  _UserNameInputState createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5.0),
            ),
            fillColor: Colors.lightBlueAccent,
            labelText: translate(Lz.Login_Page_Username_Text_Label),
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

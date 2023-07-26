
import 'package:flutter/material.dart';
import 'package:fluttercrud/crud/ui/widgets/theme/theme_brightness_widget.dart';
import 'package:fluttercrud/crud/ui/widgets/theme/theme_color_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تنظیمات رنگ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ThemeBrightnessWidget(),
              ThemeColorWidget()
            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/localization/lz.dart';
import '../enums.dart';

class ThemeColorModel {
  final ThemeColor color;

  ThemeColorModel(this.color);

  MaterialColor getThemeColor() {
    MaterialColor materialColor;

    if (color == ThemeColor.blue) {
      materialColor = Colors.blue;
    } else if (color == ThemeColor.red) {
      materialColor = Colors.red;
    } else if (color == ThemeColor.orange) {
      materialColor = Colors.orange;
    } else if (color == ThemeColor.green) {
      materialColor = Colors.green;
    } else if (color == ThemeColor.pink) {
      materialColor = Colors.pink;
    } else if (color == ThemeColor.cyan) {
      materialColor = Colors.cyan;
    }

    return materialColor;
  }

  String getThemeColorName() {
    String name = '';

    if (color == ThemeColor.blue)
      name = 'آبی';
    else if (color == ThemeColor.red)
      name =  'قرمز';
    else if (color == ThemeColor.orange)
      name =  'نارنجی';
    else if (color == ThemeColor.green)
      name =  'سبز';
    else if (color == ThemeColor.pink)
      name = 'صورنی';
    else if (color == ThemeColor.cyan)
      name = 'فیروزه ای';

    return name;
  }
}

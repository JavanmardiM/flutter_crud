
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/localization/lz.dart';

class ThemeBrightnessModel {
  final Brightness brightness;

  ThemeBrightnessModel(this.brightness);

  String getThemeBrightnessName() {
    String name = '';

    if (brightness == Brightness.light)
      name = 'روشن';
    else if (brightness == Brightness.dark)
      name = 'تیره';

    return name;
  }
}

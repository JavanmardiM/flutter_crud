import 'package:flutter/material.dart';
import '../theme_model.dart';
import '../app_theme.dart';

class ThemeDisplay {
  ThemeData defaultDisplay() {
    AppTheme.color = AppTheme.colorDefault();
    AppTheme.brightness = AppTheme.brightnessDefault();

    return AppTheme.theme();
  }

  ThemeModel applyColor(ThemeColor color) {
    AppTheme.color = color;
    return ThemeModel(
        AppTheme.theme());
  }

  ThemeModel afterBrightness(Brightness brightness) {
    AppTheme.brightness = brightness;
    return ThemeModel(
        AppTheme.theme());
  }
}

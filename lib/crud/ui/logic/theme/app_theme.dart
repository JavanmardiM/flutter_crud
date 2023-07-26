
import 'package:flutter/material.dart';
import 'display/theme_color_model.dart';
import 'enums.dart';

export 'enums.dart';
export 'theme_model.dart';
export 'display/theme_color_model.dart';
export 'display/theme_brightness_model.dart';
export 'display/theme_display.dart';

class AppTheme {
  static ThemeType themeType = themeTypeDefault();
  static ThemeColor color = colorDefault();
  static Brightness brightness = brightnessDefault();
//  static ThemeFontFamily fontFamily = fontFamilyDefault();
  static double textScale = textScaleDefault();

  static ThemeType themeTypeDefault() {
    return ThemeType.simple;
  }

  static double textScaleDefault() {
    return 1;
  }

  // ignore: missing_return
//  static ThemeFontFamily fontFamilyDefault() {
//    if (AppLanguage.languageModel.language == Language.fa)
//      return ThemeFontFamily.SHABNAM_FD;
//    else
//      return ThemeFontFamily.PROXIMA_NOVA;
//  }

  static ThemeColor colorDefault() {
    return ThemeColor.green;
  }

  static Brightness brightnessDefault() {
    return Brightness.dark;
  }

  static ThemeData theme() {
    MaterialColor materialColor =
        ThemeColorModel(AppTheme.color).getThemeColor();

    return ThemeData(
      brightness: AppTheme.brightness,
      primarySwatch: materialColor,
      primaryColor: materialColor.shade500,
      primaryColorBrightness: AppTheme.brightness,
      accentColor: materialColor.shade500,
      accentColorBrightness: AppTheme.brightness,

//      fontFamily: fontFamily.toString().split('.').last,
    );
  }
}

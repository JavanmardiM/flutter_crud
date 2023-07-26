import 'package:fluttercrud/crud/ui/logic/theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeColorChanged extends ThemeEvent {
  final ThemeColor themeColor;

  ThemeColorChanged(this.themeColor);

  @override
  List<Object> get props => [themeColor];
}

class ThemeBrightnessChanged extends ThemeEvent {
  final Brightness brightness;

  ThemeBrightnessChanged(this.brightness);

  @override
  List<Object> get props => [brightness];
}

//class FontFamilyChangedByChangedLanguage extends ThemeEvent {
//  final Language language;
//
//  FontFamilyChangedByChangedLanguage(this.language);
//}

class ThemeTextScaleChanged extends ThemeEvent {
  final double scale;

  ThemeTextScaleChanged(this.scale);

  @override
  List<Object> get props => [scale];
}
import 'package:fluttercrud/crud/ui/logic/theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';


@immutable
abstract class ThemeState extends Equatable {
  final ThemeModel themeModel;

  ThemeState(this.themeModel);

  @override
  List<Object> get props => [];
}

class DefaultThemeState extends ThemeState {
  DefaultThemeState(ThemeModel themeModel) : super(themeModel);

  @override
  List<Object> get props => [themeModel];
}

class ThemeColorState extends ThemeState {
  ThemeColorState(ThemeModel themeModel) : super(themeModel);

  @override
  List<Object> get props => [themeModel];
}

class ThemeBrightnessState extends ThemeState {
  ThemeBrightnessState(ThemeModel themeModel) : super(themeModel);

  @override
  List<Object> get props => [themeModel];
}

class FontFamilyState extends ThemeState {
  FontFamilyState(ThemeModel themeModel) : super(themeModel);

  @override
  List<Object> get props => [themeModel];
}

class ThemeTextScaleState extends ThemeState {
  ThemeTextScaleState(ThemeModel themeModel) : super(themeModel);

  @override
  List<Object> get props => [themeModel];
}
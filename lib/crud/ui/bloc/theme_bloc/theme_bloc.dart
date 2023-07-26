import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttercrud/crud/ui/logic/theme/app_theme.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeState get initialState => DefaultThemeState(ThemeModel(
      ThemeDisplay().defaultDisplay()));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeColorChanged) {
      yield ThemeColorState(ThemeDisplay().applyColor(event.themeColor));
    } else if (event is ThemeBrightnessChanged) {
      yield ThemeBrightnessState(ThemeDisplay().afterBrightness(event.brightness));
    }
  }
}

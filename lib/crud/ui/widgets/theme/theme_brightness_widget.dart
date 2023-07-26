
import 'package:fluttercrud/crud/ui/bloc/theme_bloc/bloc.dart';
import 'package:fluttercrud/crud/ui/logic/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeBrightnessWidget extends StatefulWidget {
  @override
  _ThemeBrightnessWidgetState createState() => _ThemeBrightnessWidgetState();
}

class _ThemeBrightnessWidgetState extends State<ThemeBrightnessWidget> {
  Brightness _brightness = Brightness.dark;

  List<ThemeBrightnessModel> themeBrightnesses = List();

  @override
  void initState() {
    super.initState();

    themeBrightnesses.add(ThemeBrightnessModel(Brightness.light));
    themeBrightnesses.add(ThemeBrightnessModel(Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(children: <Widget>[
        Text('روشنایی'),
        Column(
          children: <Widget>[
            _radioThemeBrightness(themeBrightnesses[0]),
            _radioThemeBrightness(themeBrightnesses[1])
          ],
        )
      ]),
    );
  }

  _radioThemeBrightness(ThemeBrightnessModel model) {
    return RadioListTile<Brightness>(
      activeColor: AppTheme.brightness == Brightness.light
          ? Colors.black54
          : Colors.white70,
      title: Text(model.getThemeBrightnessName()),
      value: model.brightness,
      groupValue: _brightness,
      onChanged: (Brightness value) {
        setState(() {
          _brightness = value;
          BlocProvider.of<ThemeBloc>(context).add(
            ThemeBrightnessChanged(_brightness),
          );
        });
      },
    );
  }
}

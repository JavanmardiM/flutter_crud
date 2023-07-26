
import 'package:fluttercrud/crud/ui/bloc/theme_bloc/bloc.dart';
import 'package:fluttercrud/crud/ui/bloc/theme_bloc/theme_event.dart';
import 'package:fluttercrud/crud/ui/logic/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeColorWidget extends StatefulWidget {
  @override
  _ThemeColorWidgetState createState() => _ThemeColorWidgetState();
}

class _ThemeColorWidgetState extends State<ThemeColorWidget> {
  ThemeColor _tavThemeColor = ThemeColor.green;

  List<ThemeColorModel> themeColors = List();

  @override
  void initState() {
    super.initState();

    themeColors.add(ThemeColorModel(ThemeColor.blue));
    themeColors.add(ThemeColorModel(ThemeColor.red));
    themeColors.add(ThemeColorModel(ThemeColor.orange));
    themeColors.add(ThemeColorModel(ThemeColor.green));
    themeColors.add(ThemeColorModel(ThemeColor.pink));
    themeColors.add(ThemeColorModel(ThemeColor.cyan));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('رنگ'),
      _radioThemeColor(themeColors[0]),
      _radioThemeColor(themeColors[1]),
      _radioThemeColor(themeColors[2]),
      _radioThemeColor(themeColors[3]),
      _radioThemeColor(themeColors[4]),
      _radioThemeColor(themeColors[5])


    ]);
  }

  _radioThemeColor(ThemeColorModel model){
    return RadioListTile<ThemeColor>(
      activeColor: model.getThemeColor(),
      title: Text(model.getThemeColorName()),
      value: model.color,
      groupValue: _tavThemeColor,
      onChanged: (ThemeColor value) {
        setState(() {
          _tavThemeColor = value;
          BlocProvider.of<ThemeBloc>(context).add(
            ThemeColorChanged(_tavThemeColor),
          );
        });
      },
    );
  }
}





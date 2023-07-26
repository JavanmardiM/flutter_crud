import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'crud/ui/bloc/theme_bloc/bloc.dart';
import 'crud/ui/bloc/theme_bloc/theme_bloc.dart';
import 'start_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'fa']);

  runApp(LocalizedApp(delegate, MyApp()));
}



class MyApp extends StatelessWidget {
  bool firstBuild = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(!firstBuild){
      firstBuild = true;
      changeLocale(context, 'fa');
    }

    return BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(), child: StartApp());
  }
}

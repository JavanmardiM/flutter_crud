import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/crud/ui/bloc/bloc.dart';
import 'crud/ui/bloc/theme_bloc/bloc.dart';
import 'crud/ui/pages/contact_details_page.dart';
import 'crud/ui/pages/contact_list_page.dart';
import 'crud/ui/pages/contact_register_page.dart';
import 'crud/ui/pages/login_page.dart';
import 'crud/ui/pages/setting_page.dart';

class StartApp extends StatefulWidget {
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  ThemeData _themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return  BlocBuilder(
        bloc: BlocProvider.of<ThemeBloc>(context),
        builder: (BuildContext context, ThemeState state) {
          if (state is ThemeColorState)
            _themeData = state.themeModel.themeData;
          else if (state is ThemeBrightnessState)
            _themeData = state.themeModel.themeData;
          else if (state is DefaultThemeState)
            _themeData = state.themeModel.themeData;

          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: _themeData,
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);

              Widget mediaQueryWidget = MediaQuery(
                data: data.copyWith(textScaleFactor: data.textScaleFactor * 1),
                child: child,
              );

              Widget direction = Directionality(
                textDirection: TextDirection.rtl,
                child: mediaQueryWidget,
              );

              return BlocProvider<ContactBloc>(
                create: (BuildContext context) => ContactBloc(),
                child: direction,
              );
            },
            initialRoute: '/login',
            routes: {
              '/contact-list': (context) => ContactListPage(),
              '/contact-register': (context) => ContactRegisterPage(),
              '/login': (context) => LoginPage(),
              '/contact-details': (context) => ContactDetailsPage(),
              '/setting': (context) => SettingPage(),
            },
          );
        },
      );
  }
}

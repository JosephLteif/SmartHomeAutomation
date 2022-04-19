import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/views/LoginPage.dart';
import 'package:smarthomeautomation/views/SetTokenPage.dart';
import 'providers/OpenHabState.dart';
import 'utils/colors.dart';
import 'views/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppearanceState>(
              create: (context) => AppearanceState()),
          ChangeNotifierProvider<OpenHabState>(
              create: (context) => OpenHabState()),
        ],
        child: Consumer<AppearanceState>(
          builder: ((context, value, child) => MaterialApp(
                title: 'Smart Home',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: lightColorTheme,
                ),
                darkTheme: ThemeData(
                  primarySwatch: darkColorTheme,
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: darkColorScaffoldTheme,
                  inputDecorationTheme: InputDecorationTheme(),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: darkColorScaffoldTheme,
                  ),
                ),
                themeMode: value.getThemeMode(),
                routes: {
                  '/': (context) => const LoginPage(),
                  '/main': (context) => const MainPage(),
                  '/setToken': (context) => SetTokenPage(),
                },
              )),
        ));
  }
}

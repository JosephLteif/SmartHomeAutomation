import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/views/IntroSlider.dart';

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
                title: 'Flutter Demo',
                theme: ThemeData.light(),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: darkColorScaffoldTheme,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: darkColorScaffoldTheme,
                  ),
                ),
                themeMode: value.getThemeMode(),
                routes: {
                  '/': (context) => IntroPage(),
                  '/main': (context) => const MainPage(),
                },
              )),
        ));
  }
}

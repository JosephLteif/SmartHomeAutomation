import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/views/IntroSlider.dart';

import 'providers/ThingsState.dart';
import 'utils/colors.dart';

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
          ChangeNotifierProvider<ThingsState>(
              create: (context) => ThingsState()),
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
                home: IntroPage(),
              )),
        ));
  }
}

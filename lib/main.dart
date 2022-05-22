import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AddSensorState.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/views/FingerPrintPage.dart';
import 'package:smarthomeautomation/views/LoginPage.dart';
import 'package:smarthomeautomation/views/QRScannerPage.dart';
import 'package:smarthomeautomation/views/SetTokenPage.dart';
import 'providers/OpenHabState.dart';
import 'utils/colors.dart';
import 'views/MainPage.dart';
import 'views/PlaceHolderPage.dart';

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
          ChangeNotifierProvider<AddSensorState>(
              create: (context) => AddSensorState()),
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
                  inputDecorationTheme: const InputDecorationTheme(),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: darkColorScaffoldTheme,
                  ),
                ),
                themeMode: value.getThemeMode(),
                onUnknownRoute: (settings) => MaterialPageRoute(
                    builder: (context) => const PlaceHolderPage()),
                routes: {
                  '/': (context) => const LoginPage(),
                  '/main': (context) => const MainPage(),
                  '/setToken': (context) => SetTokenPage(),
                  '/qrscanner': (context) => QRScannerPage(),
                  '/authPage': (context) => const FingerPrintPage(),
                },
              )),
        ));
  }
}

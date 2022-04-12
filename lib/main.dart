import 'package:flutter/material.dart';
import 'package:smarthomeautomation/views/IntroSlider.dart';

import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: lightColorTheme,
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarColor: Colors.white,
      ),
      home: IntroPage(),
    );
  }
}


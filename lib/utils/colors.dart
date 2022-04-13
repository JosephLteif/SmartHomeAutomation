import 'package:flutter/material.dart';

Map<int, Color> color = {
50: Color.fromRGBO(118,98,255, .1),
100: Color.fromRGBO(118,98,255, .2),
200: Color.fromRGBO(118,98,255, .3),
300: Color.fromRGBO(118,98,255, .4),
400: Color.fromRGBO(118,98,255, .5), 
500: Color.fromRGBO(118,98,255, .6),
600: Color.fromRGBO(118,98,255, .7),
700: Color.fromRGBO(118,98,255, .8),
800: Color.fromRGBO(118,98,255, .9),
900: Color.fromRGBO(118,98,255, 1),
};

MaterialColor lightColorTheme = MaterialColor(0xFF7662ff, color);

Map<int, Color> darkcolor = {
50: Color.fromRGBO(51, 255, 236, .1),
100: Color.fromRGBO(51, 255, 236, .2),
200: Color.fromRGBO(51, 255, 236, .3),
300: Color.fromRGBO(51, 255, 236, .4),
400: Color.fromRGBO(51, 255, 236, .5), 
500: Color.fromRGBO(51, 255, 236, .6),
600: Color.fromRGBO(51, 255, 236, .7),
700: Color.fromRGBO(51, 255, 236, .8),
800: Color.fromRGBO(51, 255, 236, .9),
900: Color.fromRGBO(51, 255, 236, 1),
};

MaterialColor darkColorTheme = MaterialColor(0xFF33e1ec, color);

Color darkColorScaffoldTheme = Color(0xFF1f1f2d);




Color navigationinactivecolor = Color(0xFF263238);
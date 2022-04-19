import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  var prefs;

  init() async{
    prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  AppearanceState() {
    init();
  }

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

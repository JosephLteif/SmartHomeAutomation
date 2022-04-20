import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/utils/labels.dart';

class AppearanceState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  var prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(prefs_IsDarkMode) ?? false;
    notifyListeners();
  }

  AppearanceState() {
    init();
  }

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefs_IsDarkMode, _isDarkMode);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

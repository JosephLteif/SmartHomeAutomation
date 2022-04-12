import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppearanceState extends ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    return isDarkMode?ThemeMode.dark:ThemeMode.light;
  }
  
}
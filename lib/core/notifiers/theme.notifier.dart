import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app.keys.dart';

class ThemeNotifier with ChangeNotifier {
  bool _darktheme = true;
  // ignore: unnecessary_getters_setters
  bool get darkTheme => _darktheme;

  set darkTheme(bool value) {
    _darktheme = value;
  }

  ThemeNotifier() {
    _loadFromPrefs();
  }

  toggleTheme() {
    _darktheme = !_darktheme;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    var val = await getDarkMode();
    _darktheme = val ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await saveDarkMode(_darktheme);
  }

  static Future<bool> saveDarkMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AppKeys.appMode, darkMode);
  }

  static Future<bool?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppKeys.appMode);
  }
}

import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeController({ThemeMode initialThemeMode = ThemeMode.system})
    : _themeMode = initialThemeMode;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  void setLight() {
    _setThemeMode(ThemeMode.light);
  }

  void setDark() {
    _setThemeMode(ThemeMode.dark);
  }

  void setSystem() {
    _setThemeMode(ThemeMode.system);
  }

  void toggle() {
    switch (_themeMode) {
      case ThemeMode.system:
        setLight();
        return;
      case ThemeMode.light:
        setDark();
        return;
      case ThemeMode.dark:
        setSystem();
        return;
    }
  }

  void _setThemeMode(ThemeMode value) {
    if (_themeMode == value) {
      return;
    }

    _themeMode = value;
    notifyListeners();
  }
}

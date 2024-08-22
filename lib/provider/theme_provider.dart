import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider(bool darkMode) {
    _themeData = darkMode ? _darkTheme() : _lightTheme();
  }

  ThemeData get themeData => _themeData;

  void toggleTheme(UserSettingsModel userSettings) {
    userSettings.darkMode = !userSettings.darkMode;
    userSettings.save();

    _themeData = userSettings.darkMode ? _darkTheme() : _lightTheme();
    notifyListeners();
  }

  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
        surfaceBright: Color(0xFF111111),
        surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.2),
        primary: Color(0xFFFFFFFF),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        surface: Color(0xFFF7F8F7),
        surfaceBright: Colors.white,
        surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.2),
        primary: Color(0xFF222222),
      ),
    );
  }
}

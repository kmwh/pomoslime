import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';

class ThemeProvider with ChangeNotifier {
  final UserSettingsModel _userSettings;

  ThemeProvider(this._userSettings);

  ThemeData get themeData => _userSettings.darkMode ? _darkTheme : _lightTheme;
  bool get darkMode => _userSettings.darkMode;

  void toggle() {
    _userSettings.darkMode = !_userSettings.darkMode;
    _userSettings.save();
    notifyListeners();
  }

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
      surfaceBright: Color(0xFF111111),
      surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.2),
      primary: Color(0xFFFFFFFF),
    ),
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFF7F8F7),
      surfaceBright: Colors.white,
      surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.2),
      primary: Color(0xFF222222),
    ),
  );
}

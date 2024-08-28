import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class ThemeProvider with ChangeNotifier {
  final UserDataModel _userData;

  ThemeProvider(this._userData);

  ThemeData get themeData => _userData.darkMode ? _darkTheme : _lightTheme;
  bool get darkMode => _userData.darkMode;

  void toggle() {
    _userData.darkMode = !_userData.darkMode;
    _userData.save();
    notifyListeners();
  }

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
      surfaceBright: Color(0xFF111111),
      surfaceContainer: Color.fromRGBO(255, 255, 255, 0.1),
      surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.4),
      primary: Color(0xFFFFFFFF),
      primaryContainer: Color.fromRGBO(255, 255, 255, 0.668),
      secondary: Color.fromARGB(255, 196, 196, 196),
    ),
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFF7F8F7),
      surfaceBright: Colors.white,
      surfaceContainer: Color.fromRGBO(0, 0, 0, 0.1),
      surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.4),
      primary: Color(0xFF222222),
      primaryContainer: Color.fromRGBO(0, 0, 0, 0.812),
      secondary: Color.fromARGB(255, 255, 206, 8),
    ),
  );
}

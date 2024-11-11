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
      surfaceBright: Color.fromARGB(255, 23, 23, 23),
      surfaceContainer: Color.fromARGB(255, 43, 43, 43),
      surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.26),
      primary: Color(0xFFFFFFFF),
      primaryContainer: Color.fromRGBO(255, 255, 255, 0.668),
      secondary: Color.fromRGBO(255, 244, 90, 1),
      secondaryContainer: Color.fromRGBO(86, 36, 90, 0.6),
    ),
    fontFamily: "Im",
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(255, 246, 246, 246),
      surfaceBright: Colors.white,
      surfaceContainer: Color.fromARGB(255, 233, 233, 233),
      surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.26),
      primary: Color(0xFF222222),
      primaryContainer: Color.fromRGBO(0, 0, 0, 0.812),
      secondary: Color.fromARGB(255, 196, 54, 209),
      secondaryContainer: Color.fromARGB(230, 255, 214, 64),
    ),
    fontFamily: "Im",
  );
}

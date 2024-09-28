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
      surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.4),
      primary: Color(0xFFFFFFFF),
      primaryContainer: Color.fromRGBO(255, 255, 255, 0.668),
      secondary: Color.fromARGB(255, 196, 196, 196),
      secondaryContainer: Color.fromRGBO(255, 224, 46, 0.3),
      secondaryFixed: Color.fromRGBO(246, 255, 179, 1),
    ),
    fontFamily: "Im",
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(255, 246, 246, 246),
      surfaceBright: Colors.white,
      surfaceContainer: Color.fromARGB(255, 233, 233, 233),
      surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.4),
      primary: Color(0xFF222222),
      primaryContainer: Color.fromRGBO(0, 0, 0, 0.812),
      secondary: Color.fromARGB(255, 255, 224, 46),
      secondaryContainer: Color.fromRGBO(255, 46, 213, 0.3),
      secondaryFixed: Color.fromARGB(255, 151, 24, 109),
    ),
    fontFamily: "Im",
  );
}

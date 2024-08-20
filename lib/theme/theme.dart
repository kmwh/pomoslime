import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF7F8F7),
    surfaceBright: Colors.white,
    surfaceContainerLowest: Color.fromRGBO(0, 0, 0, 0.2),
    primary: Color(0xFF222222),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    surfaceBright: Color(0xFF111111),
    surfaceContainerLowest: Color.fromRGBO(255, 255, 255, 0.2),
    primary: Color(0xFFFFFFFF),
  ),
);

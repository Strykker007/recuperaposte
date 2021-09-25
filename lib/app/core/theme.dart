import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primaryColor: const Color(0xFFF48121),
  primaryColorDark: const Color(0xFFE76901),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  cardColor: const Color(0xFF737375),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFF48121),
    disabledColor: Color(0xFFE5E5E5),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFFF48121),
    selectionColor: const Color(0xFFF48121).withOpacity(0.5),
    selectionHandleColor: const Color(0xFFF48121),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFFF48121),
    primaryVariant: Color(0xFFE76901),
    secondary: Color(0xFFF48121),
    secondaryVariant: Color(0xFFE76901),
    surface: Colors.red,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Color(0xFFF48121),
    onSecondary: Color(0xFFF48121),
    onSurface: Color(0xFFF48121),
    onBackground: Colors.white,
    onError: Colors.red,
    brightness: Brightness.light,
  ),
);

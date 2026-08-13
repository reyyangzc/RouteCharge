import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color darkBackground = Color(0xFF12181B);
  static const Color cardBackground = Color(0xFF1E262C);
  static const Color fastChargerOrange = Color(0xFFFF9100);
  static const Color slowChargerBlue = Color(0xFF29B6F6);
  static const Color textLight = Color(0xFFECEFF1);
  static const Color textMuted = Color(0xFF90A4AE);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: fastChargerOrange,
        surface: cardBackground,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textLight),
        bodyMedium: TextStyle(color: textMuted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AppTheme {
  // Brand Color Palette (Neon / Dark Concept)
  static const Color backgroundColor = Color(0xFF111618);
  static const Color cardColor = Color(0xFF1E2628);
  static const Color primaryNeon = Color(0xFF00F5A0);
  static const Color secondaryAccent = Color(0xFF15B8A6);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF9CA3AF);

  // Backward compatibility aliases
  static const Color cardBackgroundColor = cardColor;
  static const Color primaryGreen = primaryNeon;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.dark(
        surface: cardColor,
        primary: primaryNeon,
        secondary: secondaryAccent,
        onSurface: textPrimary,
      ),
      // Fix for CardThemeData type error
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryNeon,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
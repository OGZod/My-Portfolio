import 'package:flutter/material.dart';

class AppColors {
  // Main colors
  static const primary = Color(0xFF3A4256);      // Deep slate blue-gray - minimalist and professional
  static const secondary = Color(0xFF525B74);    // Lighter variant of primary

  // Accent color - used sparingly for highlights
  static const accent = Color(0xFFD4AF37);       // Gold for subtle accents

  // Background colors
  static const backgroundLight = Color(0xFFF8F9FA);  // Very light gray for light mode
  static const backgroundDark = Color(0xFF1A202C);   // Deep blue-gray for dark mode

  // Text colors
  static const textDark = Color(0xFF303030);     // Almost black but softer
  static const textLight = Color(0xFFF0F0F0);    // Almost white but softer
  static const textMuted = Color(0xFF71717A);    // Muted text for secondary information

  // Status/feedback colors
  static const success = Color(0xFF4A9D7E);      // Muted green
  static const error = Color(0xFFB95D62);        // Muted red
  static const warning = Color(0xFFD7A74A);      // Muted amber

  // Surface/card colors
  static const surfaceLight = Colors.white;
  static const surfaceDark = Color(0xFF252A37);  // Slightly lighter than dark background

  // Border colors
  static const borderLight = Color(0xFFE0E0E0);
  static const borderDark = Color(0xFF3A4256);   // Same as primary

  // Helper method to get theme-based colors
  static Color getBackgroundColor(bool isDarkMode) =>
      isDarkMode ? backgroundDark : backgroundLight;

  static Color getTextColor(bool isDarkMode) =>
      isDarkMode ? textLight : textDark;

  static Color getSurfaceColor(bool isDarkMode) =>
      isDarkMode ? surfaceDark : surfaceLight;

  static Color getBorderColor(bool isDarkMode) =>
      isDarkMode ? borderDark : borderLight;
}
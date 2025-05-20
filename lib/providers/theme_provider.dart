
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isSystemTheme = true;
  
  ThemeProvider() {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;
  bool get isSystemTheme => _isSystemTheme;

  // Get current theme based on user preference or system setting
  bool get currentThemeIsDark {
    if (_isSystemTheme) {
      // Use system theme
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    // Use user-selected theme
    return _isDarkMode;
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isSystemTheme = prefs.getBool('isSystemTheme') ?? true;
    notifyListeners();
  }

  // Toggle between light and dark theme
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _isSystemTheme = false;
    await _saveThemePreference();
    notifyListeners();
  }

  // Set to system theme
  Future<void> setSystemTheme() async {
    _isSystemTheme = true;
    await _saveThemePreference();
    notifyListeners();
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setBool('isSystemTheme', _isSystemTheme);
  }
}
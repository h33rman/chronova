// File: lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // To save theme preference

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme
  static const String _themeModeKey = 'themeMode';

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  // Load theme preference from SharedPreferences
  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final int? storedThemeMode = prefs.getInt(_themeModeKey);

    if (storedThemeMode != null) {
      _themeMode = ThemeMode.values[storedThemeMode];
    }
    notifyListeners(); // Notify listeners after loading
  }

  // Set new theme mode and save preference
  void setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeModeKey, mode.index); // Save the index of the enum
    }
  }

  // Convenience methods for toggling
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }
}
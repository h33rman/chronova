import 'package:flutter/material.dart';

class AppColorSchemes {
  static ColorScheme get darkColorScheme {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.deepPurple, // Deep Purple (example primary)
      onPrimary: Colors.white, // Text color on primary backgrounds

      secondary: Colors.purpleAccent, // Purple Accent (example secondary)
      onSecondary: Colors.white, // Text color on secondary backgrounds

      tertiary: Color(0xFF480050), // Tertiary color (example)
      onTertiary: Color(0xFFe482e8), // Text color on tertiary backgrounds

      error: Color(0xFFCF6679), // Red for errors
      onError: Colors.black, // Text color on error backgrounds

      surface: Color(0xFF28264F), // Your primary surface color (e.g., card backgrounds, input fields)
      onSurface: Colors.white, // Text color on surfaces
    );
  }

// You can add other color schemes here if you plan to support light mode etc.
// static ColorScheme get lightColorScheme {
//   return const ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xFF6200EE),
//     onPrimary: Colors.white,
//     secondary: Color(0xFF03DAC6),
//     onSecondary: Colors.black,
//     error: Color(0xFFB00020),
//     onError: Colors.white,
//     background: Colors.white,
//     onBackground: Colors.black,
//     surface: Colors.white,
//     onSurface: Colors.black,
//   );
// }
}
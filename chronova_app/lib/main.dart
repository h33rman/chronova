import 'package:chronova_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChronovApp());
}

class ChronovApp extends StatelessWidget {
  const ChronovApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), // Use BottomBarMenu as the main screen
    );
  }
}
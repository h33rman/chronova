import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF222142),
      ),
      body: Container(
        color: const Color(0xFF28264F), // Full body background color
        child: const Center(
          child: Text(
            "Welcome to the Home Screen!",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
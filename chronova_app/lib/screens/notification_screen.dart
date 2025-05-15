import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF222142),
      ),
      body: Container(
        color: const Color(0xFF28264F), // Full body background color
        child: const Center(
          // Center the text in the middle of the screen  
        child: Text("Welcome to the Notification Screen!", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    ));
  }
}
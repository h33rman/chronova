import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xFF222142),
      ),
      body: const Center(
        child: Text("Welcome to the Notification Screen!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
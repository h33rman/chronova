import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        backgroundColor: const Color(0xFF222142),
      ),
      body: const Center(
        child: Text("Welcome to the News Screen!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
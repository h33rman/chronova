import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF222142),
      ),
      body: Container(
        color: const Color(0xFF28264F), // Full body background color
        
        child: const Center(
          child: Text(
            "Welcome to the News Screen!",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
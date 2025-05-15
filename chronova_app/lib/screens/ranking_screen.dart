import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF222142),
      ),
      body: Container(
        color: const Color(0xFF28264F), // Full body background color
        child: const Center(
          child: Text(
            "Welcome to the Ranking Screen!",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
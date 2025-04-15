import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking"),
        backgroundColor: const Color(0xFF222142),
      ),
      body: const Center(
        child: Text("Welcome to the Ranking Screen!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
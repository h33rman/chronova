import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF222142),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Welcome!", style: TextStyle(color: Colors.white)),
            Text("User Name", style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF28264F),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Game Mode",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      _buildGameCard(
                        context,
                        "Play Online",
                        "assets/img/chronova_bg.png",
                        "/online",
                      ),
                      // Add spacing between rows
                      _buildGameCard(
                        context,
                        "Play Offline",
                        "assets/img/chronova_bg.png",
                        "/offline",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
      BuildContext context,
      String title,
      String imagePath,
      String routePath,
      ) {
    return SizedBox( // Use SizedBox to control the width of each card
      width: double.infinity, // Make each card take the full width
      height: 200, // Adjust the height as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepPurple[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  context.push(routePath);
                },
                label: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Adjust font size for better readability in rows
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold)),
                icon: const Icon(Icons.videogame_asset_outlined,
                    color: Colors.white, size: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
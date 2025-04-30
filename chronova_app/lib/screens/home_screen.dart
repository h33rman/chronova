import 'package:flutter/material.dart';

import '../models/on_game.dart';

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
        // Image as background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/chronova_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column( // Use Column to fill the screen
          children: [
            Expanded( // Expanded to take remaining space
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text("Game Mode", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2
                          ),)),),
                      const SizedBox(height: 20),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(child: _buildGameCard(context, "Play Offline", "assets/img/img_play_offline.png")),
                          Expanded(child: _buildGameCard(context, "Play Online", "assets/img/img_play_online.png")),
                        ],
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

  Widget _buildGameCard(BuildContext context, String title, String imagePath) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height 70% of the card
              height: 150,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  scale: 0.7,
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () { // Play Game offline Setup
              },
              label: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold)),
              icon: const Icon(Icons.videogame_asset_outlined,
                  color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the Play Offline options as a bottom sheet
}
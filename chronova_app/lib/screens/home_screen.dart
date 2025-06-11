// File: lib/screens/online/home_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chronova_app/services/auth_service.dart'; // NEW: Import AuthService

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // NEW: Get the current user from the auth service
    final user = authService.value.currentUser;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF222142),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome!", style: TextStyle(color: Colors.white)),
            // NEW: Display the user's name or email if available
            Text(
              user?.displayName ?? user?.email ?? "User",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        actions: [
          // NEW: Add a logout button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 30),
            tooltip: 'Logout',
            onPressed: () async {
              // Simply call signOut. The AuthGate will do the rest!
              await authService.value.signOut();
            },
          ),
          const SizedBox(width: 10), // Add some spacing
        ],
      ),
      body: Container(
        color: const Color(0xFF28264F),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 20), // FIX: Use SizedBox for spacing
                _buildGameCard(
                  context,
                  "Play Online",
                  "assets/img/chronova_bg.png",
                  "/online",
                ),
                const SizedBox(height: 20), // FIX: Use SizedBox for spacing
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
    );
  }

  Widget _buildGameCard(
      BuildContext context,
      String title,
      String imagePath,
      String routePath,
      ) {
    // ... no changes needed in this helper method ...
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        fontSize: 16,
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
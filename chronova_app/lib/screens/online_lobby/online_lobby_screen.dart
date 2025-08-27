// File: lib/screens/online_lobby_screen.dart

import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

class OnlineLobbyScreen extends StatelessWidget {
  const OnlineLobbyScreen({super.key});

  // Mock data for available rooms
  final List<Map<String, dynamic>> availableRooms = const [
    {'name': 'Cosmic Challengers', 'players': '1/2', 'avatar': 'assets/images/default_avatar.png'},
    {'name': 'Galaxy Gladiators', 'players': '2/2', 'avatar': 'assets/images/default_avatar.png'},
    {'name': 'Starlight Strikers', 'players': '1/2', 'avatar': 'assets/images/default_avatar.png'},
    {'name': 'Nebula Navigators', 'players': '1/2', 'avatar': 'assets/images/default_avatar.png'},
    {'name': 'Supernova Seekers', 'players': '2/2', 'avatar': 'assets/images/default_avatar.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows body to go behind app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: 0.2),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back',
            ),
          ),
        ),
        title: Text(
          "Online Lobby",
          style: textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(blurRadius: 5.0, color: Colors.black54)
              ]
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cover_org.jpg"), // Make sure you have this image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Frosted Glass Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Create Room Card
                  _buildCreateRoomCard(context, colorScheme, textTheme),
                  const SizedBox(height: 30),
                  // Available Rooms Header
                  Text(
                    "Available Rooms",
                    style: textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Room List
                  Expanded(
                    child: ListView.builder(
                      itemCount: availableRooms.length,
                      itemBuilder: (context, index) {
                        final room = availableRooms[index];
                        final isFull = room['players'] == '2/2';
                        return _buildRoomListItem(context, room, isFull);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateRoomCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.5),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Room",
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Create a room and invite friends",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implement create room logic
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.onPrimary,
              foregroundColor: colorScheme.primary,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.add, size: 28),
          )
        ],
      ),
    );
  }

  Widget _buildRoomListItem(BuildContext context, Map<String, dynamic> room, bool isFull) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: colorScheme.surface.withValues(alpha: 0.15),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundImage: AssetImage(room['avatar']),
        ),
        title: Text(
          room['name'],
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${room['players']} Players",
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        trailing: FilledButton(
          onPressed: isFull ? null : () {
            // TODO: Implement join room logic
          },
          style: FilledButton.styleFrom(
            backgroundColor: isFull ? Colors.grey.withValues(alpha: 0.5) : colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
          ),
          child: Text(isFull ? "Full" : "Join"),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PlayerProfile extends StatelessWidget {
  final String playerName;
  final bool isPlaying;
  final String? avatarUrl; // Optional: URL for the player's avatar

  const PlayerProfile({
    super.key,
    required this.playerName,
    this.isPlaying = false,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300], // Default background color
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null ? Text(playerName[0].toUpperCase()) : null, // Fallback if no avatar
            foregroundImage: null,
          ),
          const SizedBox(width: 12),
          Text(
            playerName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollablePlayerProfiles extends StatelessWidget {
  final List<PlayerProfile> profiles;
  final String? currentlyPlayingPlayer; // Name of the player currently playing

  const ScrollablePlayerProfiles({
    super.key,
    required this.profiles,
    this.currentlyPlayingPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Provide a bounded height for the scrollable list
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final isPlaying = profile.playerName == currentlyPlayingPlayer;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isPlaying ? Colors.deepPurple : Colors.grey,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(4.0), // Add padding around the profile
            child: profile,
          );
        },
      ),
    );
  }
}
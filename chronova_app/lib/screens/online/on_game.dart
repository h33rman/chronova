import 'package:flutter/material.dart';
import 'package:chronova_app/widgets/game_card_theme.dart';
import 'package:chronova_app/widgets/game_player_profile.dart';


class GamingScreen extends StatelessWidget {
  const GamingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GameCard> gameCards = [
      const GameCard(title: 'Jupiter Discovery 1', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
      const GameCard(title: 'Jupiter Discovery 2', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
      const GameCard(title: 'Jupiter Discovery 3', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
      const GameCard(title: 'Jupiter Discovery 4', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
      const GameCard(title: 'Jupiter Discovery 5', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
      const GameCard(title: 'Jupiter Discovery 6', imagePath: 'chronova_app/assets/img/img_play_offline.png'),
    ];

    final List<PlayerProfile> playerProfiles = [
      const PlayerProfile(playerName: 'CosmicCoder', isPlaying: true),
      const PlayerProfile(playerName: 'StarSailor'),
      const PlayerProfile(playerName: 'AstroAce'),
      const PlayerProfile(playerName: 'NebulaNomad'),
      const PlayerProfile(playerName: 'GalaxyGuide'),
      const PlayerProfile(playerName: 'OrionObserver'),
      const PlayerProfile(playerName: 'SiriusSurfer'),
    ];

    const String currentlyPlaying = 'CosmicCoder';

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: const Color(0xFF222142), // Match your app bar color
            expandedHeight: 100.0, // Adjust as needed
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('On Gaming', style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0), // Height of the player list
              child: Container(
                color: const Color(0xFF28264F), // Background color for the player list
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ScrollablePlayerProfiles(
                  profiles: playerProfiles,
                  currentlyPlayingPlayer: currentlyPlaying,
                  scrollDirection: Axis.horizontal, // Make it scroll horizontally
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: gameCards.length,
              itemBuilder: (BuildContext context, int index) {
                return gameCards[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollablePlayerProfiles extends StatelessWidget {
  final List<PlayerProfile> profiles;
  final String? currentlyPlayingPlayer;
  final Axis scrollDirection; // Add scrollDirection

  const ScrollablePlayerProfiles({
    super.key,
    required this.profiles,
    this.currentlyPlayingPlayer,
    this.scrollDirection = Axis.horizontal, // Default to horizontal
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust height of the scrollable area
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final isPlaying = profile.playerName == currentlyPlayingPlayer;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Space between profiles
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isPlaying ? Colors.deepPurple : Colors.grey,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: 40, // Adjust size of the profile circle
                height: 40,
                child: Center(child: profile),
              ),
            ),
          );
        },
      ),
    );
  }
}
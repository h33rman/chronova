// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';

import 'package:chronova_app/services/auth_service.dart';
import 'package:chronova_app/widgets/daily_challenge_card.dart';
import 'package:chronova_app/widgets/game_mode_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // UPDATED: Added a 'route' key to each map to handle navigation.
  final List<Map<String, dynamic>> gameModes = [
    {
      "title": "ONLINE ROOM",
      "description": "Challenge friends & conquer global leaderboards.",
      "imagePath": "assets/images/hm_online_mode.png",
      "color": const Color(0xFF6E5DE7),
      "route": "/online_lobby", // Route for this card
    },
    {
      "title": "SOLO QUEST",
      "description": "Journey through the cosmos and test your knowledge.",
      "imagePath": "assets/images/hm_local_mode.png",
      "color": const Color(0xFFE75D84),
      "route": "/home", // Placeholder route
    },
    {
      "title": "GALAXY SURVIVAL",
      "description": "Survive an onslaught of astronomical questions.",
      "imagePath": "assets/images/hm_survey_mode.png",
      "color": const Color(0xFF5D98E7),
      "route": "/home", // Placeholder route
    }
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<AuthService>(
      valueListenable: authService,
      builder: (context, auth, child) {
        final user = auth.currentUser;

        final ImageProvider avatarImage;
        if (user != null) {
          avatarImage = (user.photoURL != null)
              ? NetworkImage(user.photoURL!)
              : const AssetImage('assets/images/default_avatar.png');
        } else {
          avatarImage = const AssetImage('assets/images/default_avatar.png');
        }

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            leadingWidth: 80,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () => context.push('/profile'),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: avatarImage,
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
              ),
            ),
            actions: [
              _buildInfoChip(Icons.flash_on, "500", Colors.amber),
              const SizedBox(width: 8),
              _buildInfoChip(Icons.diamond, "16", Colors.cyanAccent),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: colorScheme.onSurfaceVariant, size: 28),
                onPressed: () {},
              ),
              const SizedBox(width: 12),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Daily Challenges",
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DailyChallengeCard(
                  title: "Valley of the Milky Way",
                  subtitle: "Test your knowledge about our galaxy.",
                  gems: 4,
                  xp: 120,
                  imagePath: 'assets/images/astronaut_daily.png',
                  onPlay: () {},
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                //Make the height and width of the PageView dynamic based on the screen size
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.90,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: gameModes.length,
                  itemBuilder: (context, index) {
                    final mode = gameModes[index];
                    return GameModeCard(
                      title: mode['title']!,
                      description: mode['description']!,
                      imagePath: mode['imagePath']!,
                      backgroundColor: mode['color']!,
                      // UPDATED: The onStart function now uses the 'route' from the map.
                      onStart: () {
                        if (mode['route'] != null) {
                          context.push(mode['route']);
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: gameModes.length,
                  effect: ExpandingDotsEffect(
                    dotColor: colorScheme.outline.withValues(alpha: 0.5),
                    activeDotColor: colorScheme.primary,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 6.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

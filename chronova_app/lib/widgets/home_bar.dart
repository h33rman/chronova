// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:chronova_app/services/auth_service.dart';
import 'package:chronova_app/providers/theme_provider.dart';
import 'package:chronova_app/widgets/daily_challenge_card.dart'; // Import new widget
import 'package:chronova_app/widgets/game_mode_card.dart'; // Import new widget


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller to manage the page view and its current page
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Listen for page changes to update the dots indicator
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Mock data for the game modes carousel
  final List<Map<String, String>> gameModes = [
    {
      "title": "ONLINE ROOM MODE",
      "description": "Challenge friends or conquer global leaderboards in thrilling real-time battles.",
      "imagePath": "assets/images/astronaut_on_moon.png" // IMPORTANT: Replace with your image path
    },
    {
      "title": "SOLO QUEST",
      "description": "Embark on a journey through the cosmos and test your knowledge against time.",
      "imagePath": "assets/images/astronaut_on_moon.png" // IMPORTANT: Replace with your image path
    },
    {
      "title": "GALAXY SURVIVAL",
      "description": "How long can you survive against an onslaught of astronomical questions?",
      "imagePath": "assets/images/astronaut_on_moon.png" // IMPORTANT: Replace with your image path
    }
  ];

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              // Display user's Google photo or a default avatar
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              radius: 25,
              onBackgroundImageError: (exception, stackTrace) {
                // Handle case where network image fails to load
              },
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? user?.email ?? "User",
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // XP and Gem counters from Figma
          Row(
            children: [
              const Icon(Icons.flash_on, color: Colors.amber, size: 24),
              const SizedBox(width: 4),
              Text("500", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
              const SizedBox(width: 16),
              const Icon(Icons.diamond_outlined, color: Colors.cyanAccent, size: 24),
              const SizedBox(width: 4),
              Text("16", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Daily Challenges",
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Daily Challenge Card Widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 180,
                  child: DailyChallengeCard(
                    title: "The Valley of Milky Way",
                    subtitle: "Test your knowledges about our galaxy",
                    gems: 4,
                    xp: 500,
                    imagePath: 'assets/images/astronaut_daily.png', // IMPORTANT: Replace with your image path
                    onPlay: () {
                      // TODO: Handle 'Play' button tap
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Game Mode Carousel
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: gameModes.length,
                  itemBuilder: (context, index) {
                    final mode = gameModes[index];
                    return GameModeCard(
                      title: mode['title']!,
                      description: mode['description']!,
                      imagePath: mode['imagePath']!,
                      onStart: () {
                        // TODO: Navigate to the respective game mode screen
                      }, backgroundColor: Colors.white,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Dots Indicator for the Carousel
              if (gameModes.isNotEmpty)
                Center(
                  child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3, // Total number of pages
                      effect: ExpandingDotsEffect(
                        activeDotColor: colorScheme.primary,
                        dotColor: colorScheme.primary.withValues(alpha: 0.3),
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      )
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

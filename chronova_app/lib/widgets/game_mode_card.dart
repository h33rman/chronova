// File: lib/widgets/game_mode_card.dart

import 'package:flutter/material.dart';

class GameModeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback onStart;

  const GameModeCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Get the color scheme from the context
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Set the height dynamically based on the image aspect ratio
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Rectangle 1: Background color
            Container(color: backgroundColor),

            // Image wrapped in Padding
            Padding(
              // Add padding to create margins around the image
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Use 'contain' to ensure the whole image is visible
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.white54));
                },
              ),
            ),

            // Rectangle 2: Gradient Overlay using theme colors
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.scrim.withValues(alpha: 0.0), // UPDATED: Use scrim from color scheme
                    colorScheme.scrim.withValues(alpha: 0.8)  // UPDATED: Use scrim from color scheme
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1.0],
                ),
              ),
            ),

            // Content (Description and Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    // Kept as white for best readability on the dark gradient overlay
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: onStart,
                    style: FilledButton.styleFrom(
                      // UPDATED: Button colors now come from the theme
                      backgroundColor: colorScheme.surface,
                      foregroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// File: lib/widgets/daily_challenge_card.dart

import 'package:flutter/material.dart';

class DailyChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int gems;
  final int xp;
  final String imagePath;
  final VoidCallback onPlay;

  const DailyChallengeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gems,
    required this.xp,
    required this.imagePath,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // UPDATED: Gradient now uses theme colors
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.tertiary.withValues(alpha: 0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            // UPDATED: Shadow uses theme color
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPlay,
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: Image.asset(
                  imagePath,
                  width: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 100, color: colorScheme.onPrimary.withValues(alpha: 0.5));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.headlineSmall?.copyWith(
                        // UPDATED: Text color now comes from the theme
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        // UPDATED: Text color now comes from the theme
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        _buildRewardChip(context, Icons.flash_on, xp.toString(), Colors.yellow.shade700),
                        const SizedBox(width: 8),
                        _buildRewardChip(context, Icons.diamond_outlined, gems.toString(), Colors.cyan.shade300),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // UPDATED: Widget now uses context to access theme
  Widget _buildRewardChip(BuildContext context, IconData icon, String value, Color iconColor) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // UPDATED: Chip background uses theme color for adaptability
        color: colorScheme.surface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              // UPDATED: Text on chip uses a theme-aware color
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OnboardingPageTemplate extends StatelessWidget {
  final String title;
  final String description;
  final String? imagePath;

  const OnboardingPageTemplate({
    super.key,
    required this.title,
    required this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath!,
              height: 180,
              fit: BoxFit.contain,
            )
          else
            Icon(
              Icons.rocket_launch_outlined,
              size: 150,
              color: colorScheme.primary,
            ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.8),
              fontSize: 18,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
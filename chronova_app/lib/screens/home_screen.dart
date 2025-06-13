// File: lib/screens/home_screen.dart (or wherever you want the switch)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chronova_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:chronova_app/providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: colorScheme.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome!", style: TextStyle(color: colorScheme.onSurface)),
            Text(
              user?.displayName ?? user?.email ?? "User",
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Tooltip(
            message: "Toggle Theme",
            child: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
              activeColor: colorScheme.primary,
              inactiveThumbColor: colorScheme.outline,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.onSurface, size: 30),
            tooltip: 'Logout',
            onPressed: () async {
              await authService.value.signOut();
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: colorScheme.surface,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeCard(
                title: "Play Online",
                imagePath: "assets/img/chronova_bg.png",
                routePath: "/online",
                backgroundColor: colorScheme.surfaceContainerHighest ?? colorScheme.surface,
                buttonColor: colorScheme.primary,
                textColor: colorScheme.onPrimary,
              ),
              const SizedBox(height: 20),
              HomeCard(
                title: "Play Offline",
                imagePath: "assets/img/chronova_bg.png",
                routePath: "/offline",
                backgroundColor: colorScheme.surfaceContainerHighest ?? colorScheme.surface,
                buttonColor: colorScheme.primary,
                textColor: colorScheme.onPrimary,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String routePath;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const HomeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.routePath,
    required this.backgroundColor,
    required this.buttonColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  foregroundColor: textColor,
                ),
                onPressed: () {
                  context.push(routePath);
                },
                label: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.videogame_asset_outlined, color: textColor, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
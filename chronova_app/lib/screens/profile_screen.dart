// File: lib/screens/profile_screen.dart

import 'package:chronova_app/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chronova_app/services/auth_service.dart';
import 'package:chronova_app/providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We are now using a Column-based layout instead of a CustomScrollView
    // to precisely match the positioning from your example.
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: _BottomPortion(),
          ),
        ],
      ),
    );
  }
}

/// Top portion of the screen with the cover photo, app bar icons, and profile avatar.
class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    void handleSettingsSelection(String value) {
      if (value == 'logout') {
        authService.value.signOut();
        appRouter.go("/login");
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image Container
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/cover_org.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            color: colorScheme.primary, // Fallback color
          ),
        ),
        // App Bar Icons
        Positioned(
          top: 40.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.2),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Back',
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.2),
                    child: IconButton(
                      icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_rounded),
                      color: Colors.white,
                      onPressed: () {
                        final newMode = themeProvider.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                        themeProvider.setThemeMode(newMode);
                      },
                      tooltip: 'Toggle Theme',
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.2),
                    child: PopupMenuButton<String>(
                      onSelected: handleSettingsSelection,
                      icon: const Icon(Icons.settings, color: Colors.white),
                      tooltip: 'Settings',
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Profile Avatar, aligned to the bottom center of the Stack
        Align(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: CircleAvatar(
              radius: 46,
              backgroundImage: authService.value.currentUser?.photoURL != null
                  ? NetworkImage(authService.value.currentUser!.photoURL!)
                  : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
            ),
          ),
        )
      ],
    );
  }
}

/// Bottom portion of the screen with user info, stats, and friends list.
class _BottomPortion extends StatelessWidget {
  _BottomPortion();

  // Mock data for friends list
  final List<Map<String, String>> friends = [
    {"name": "Glactikos", "handle": "@galaktikos", "points": "1089", "avatar": "N"},
    {"name": "H33dev", "handle": "@h33.dev", "points": "1089", "avatar": "R"},
    {"name": "Manaka09", "handle": "@manaka09", "points": "1089", "avatar": "M"},
    {"name": "Botnoob", "handle": "@noobbot", "points": "1089", "avatar": "B"},
  ];

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            user?.displayName ?? "User Name",
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email != null ? "@${user!.email!.split('@').first}" : "@username",
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          _buildStatsCard(context, colorScheme, textTheme),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Friends", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text("Add Friends")),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return _buildFriendListItem(context, colorScheme, friends[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(icon: Icons.flash_on, label: "POINTS", value: "590", context: context),
          _buildStatItem(icon: Icons.diamond, label: "GEM", value: "16", context: context),
          _buildStatItem(icon: Icons.rocket_launch, label: "GLOBAL RANK", value: "#1045", context: context),
        ],
      ),
    );
  }

  Widget _buildStatItem({required IconData icon, required String label, required String value, required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        Text(value, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildFriendListItem(BuildContext context, ColorScheme colorScheme, Map<String, String> friend) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(friend['avatar']!, style: TextStyle(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold)),
        ),
        title: Text(friend['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(friend['handle']!),
        trailing: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.flash_on, size: 16),
          label: Text(friend['points']!),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
            foregroundColor: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

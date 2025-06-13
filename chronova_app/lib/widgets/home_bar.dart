import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/news_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/ranking_screen.dart';

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({super.key});

  @override
  State<BottomBarMenu> createState() => _BottomBarMenuState();
}

class _BottomBarMenuState extends State<BottomBarMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    NewsScreen(),
    NotificationScreen(),
    RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 12, color: colorScheme.onSurface),
          ),
        ),
        child: NavigationBar(
          height: 80,
          backgroundColor: colorScheme.surface,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(milliseconds: 400),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.sports_esports_outlined, color: colorScheme.primary, size: 40),
              selectedIcon: Icon(Icons.sports_esports, color: colorScheme.secondary, size: 40),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.rocket_outlined, color: colorScheme.primary, size: 40),
              selectedIcon: Icon(Icons.rocket_sharp, color: colorScheme.secondary, size: 40),
              label: "News",
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined, color: colorScheme.primary, size: 40),
              selectedIcon: Icon(Icons.notifications, color: colorScheme.secondary, size: 40),
              label: "Notification",
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined, color: colorScheme.primary, size: 40),
              selectedIcon: Icon(Icons.emoji_events, color: colorScheme.secondary, size: 40),
              label: "Ranking",
            ),
          ],
        ),
      ),
    );
  }
}
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
  int index = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    NewsScreen(),
    NotificationScreen(),
    RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index], // Display the selected screen
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        child: NavigationBar(
          height: 80,
          backgroundColor: const Color(0xFF222142),
          onDestinationSelected: (newIndex) {
            setState(() => index = newIndex);
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: index,
          destinations: [
            _buildNavigationItem(
              icon: Icons.sports_esports_outlined,
              selectedIcon: Icons.sports_esports,
              label: "Home",
            ),
            _buildNavigationItem(
              icon: Icons.rocket_outlined,
              selectedIcon: Icons.rocket_sharp,
              label: "News",
            ),
            _buildNavigationItem(
              icon: Icons.notifications_outlined,
              selectedIcon: Icons.notifications,
              label: "Notification",
            ),
            _buildNavigationItem(
              icon: Icons.emoji_events_outlined,
              selectedIcon: Icons.emoji_events,
              label: "Ranking",
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavigationItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    return NavigationDestination(
      icon: Icon(icon, color: Colors.deepPurple, size: 40),
      selectedIcon: Icon(selectedIcon, color: Colors.deepPurpleAccent, size: 40),
      label: label,
    );
  }
}
import 'package:flutter/material.dart';

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({super.key});

  @override
  State<BottomBarMenu> createState() => _BottomBarMenuState();
}

class _BottomBarMenuState extends State<BottomBarMenu> {

  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: const Color(0xFF222142),
        // Indicator shape for the selected item : Just a bar on the bottom
        
        labelPadding: EdgeInsets.only(top: 10, bottom: 10),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 12,
          color: Colors.white
        ))
        ), 
      child: NavigationBar(
        height: 90,
        backgroundColor: const Color(0xFF222142),
        onDestinationSelected: (index) =>
          setState(() => this.index = index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: Duration(seconds: 1),
        selectedIndex: index,
        destinations:
        [
          NavigationDestination(
            icon: Icon(color :Colors.white12,Icons.sports_esports_outlined, size: 36),
            selectedIcon: Icon(color:Colors.deepPurpleAccent, Icons.sports_esports, size: 36),
            label: "Home"),
          NavigationDestination(
            icon: Icon(color :Colors.white12,Icons.rocket_outlined,size: 36),
            selectedIcon: Icon(color:Colors.deepPurpleAccent, Icons.rocket_sharp,size: 36),
            label: "News"),
          NavigationDestination(
            icon: Icon(color :Colors.white12, Icons.notifications_outlined, size: 36),
            selectedIcon: Icon(color:Colors.deepPurpleAccent, Icons.notifications,size: 36),
            label: "Notification"),
          NavigationDestination(
            icon: Icon(color :Colors.white12, Icons.emoji_events_outlined, size: 36),
            selectedIcon: Icon(color:Colors.deepPurpleAccent, Icons.emoji_events, size: 36),
            label: "Ranking")

        ]),
  )
  );
    
  }
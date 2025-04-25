import 'package:chronova_app/screens/offfline/offline_setup.dart';
import 'package:flutter/material.dart';

class PlayOfflinePopup extends StatelessWidget {
  const PlayOfflinePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the pop-up
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OfflineSetup()), // Replace
              );
            },
            child: const Text("Practice with Bots", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.white12),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the pop-up
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlaceholderScreen(title: "Create Host")), // Replace
              );
            },
            child: const Text("Create Host", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.white12),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the pop-up
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlaceholderScreen(title: "Join Host")), // Replace
              );
            },
            child: const Text("Join Host", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

// Placeholder screen for navigation (replace with your actual screens)
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("This is the $title screen."),
      ),
    );
  }
}
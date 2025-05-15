import 'package:flutter/material.dart';
import 'package:chronova_app/widgets/player_list_item.dart';
import 'package:go_router/go_router.dart'; // Import the PlayerListItem widget

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  // Dummy list of joined user data
  List<Map<String, dynamic>> _joinedUsersData = [
    {'displayName': 'ChronovaMaster', 'username': 'chrono123', 'isHost': true},
    {'displayName': 'SpaceCadet', 'username': 'space_explorer'},
    {'displayName': 'GalaxyGlider', 'username': 'glider_77'},
    {'displayName': 'NebulaNinja', 'username': 'ninja_star'},
  ];

  bool _isHost = true; // Assume the current user is the host for now

  void _refreshLobby() {
    // Logic to fetch updated user data from the backend
    print('Refreshing lobby...');
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _joinedUsersData = [
          {'displayName': 'ChronovaMaster', 'username': 'chrono123', 'isHost': true},
          {'displayName': 'CosmicComet', 'username': 'comet_z'},
          {'displayName': 'StarStryder', 'username': 'stryder_alpha'},
          {'displayName': 'Herman R.', 'username': 'h33rman'},
          {'displayName': 'Luna L.', 'username': 'luna_lovegood'},
          {'displayName': 'NebulaNinja', 'username': 'ninja_star'},
          {'displayName': 'GalaxyGlider', 'username': 'glider_77'},
          {'displayName': 'SpaceCadet', 'username': 'space_explorer'},
          {'displayName': 'ChronovaMaster', 'username': 'chrono123'},
          {'displayName': 'CosmicComet', 'username': 'comet_z'},
          {'displayName': 'StarStryder', 'username': 'stryder_alpha'},
          {'displayName': 'Herman R.', 'username': 'h33rman'},
          {'displayName': 'Luna L.', 'username': 'luna_lovegood'},
          {'displayName': 'NebulaNinja', 'username': 'ninja_star'},
          {'displayName': 'GalaxyGlider', 'username': 'glider_77'},
          {'displayName': 'SpaceCadet', 'username': 'space_explorer'},
        ];
      });
    });
  }

  void _startGame() {
    if (_isHost) {
      print('Starting game...');
      // Navigate to game screen
      context.push('/online_lobby/on_game');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only the host can start the game.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Lobby', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF222142),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshLobby,
          ),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: const Color(0xFF28264F),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),

            const Text(
              'Joined Players:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _joinedUsersData.length,
                itemBuilder: (context, index) {
                  final userData = _joinedUsersData[index];
                  return PlayerListItem(
                    key: ValueKey(userData['username']), // Important for stateful widgets in lists
                    displayName: userData['displayName'],
                    username: userData['username'],
                    isHost: userData['isHost'] ?? false, // Default to false if not present
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isHost ? Colors.greenAccent[700] : Colors.grey[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('START PARTY'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
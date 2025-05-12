import 'package:flutter/material.dart';

class OnlineSetupScreen extends StatefulWidget {
  const OnlineSetupScreen({super.key});

  @override
  State<OnlineSetupScreen> createState() => _OnlineSetupScreenState();
}

class _OnlineSetupScreenState extends State<OnlineSetupScreen> {
  final TextEditingController _createPasscodeController = TextEditingController();
  final TextEditingController _joinRoomCodeController = TextEditingController();

  void _createRoom() {
    final passcode = _createPasscodeController.text.trim();
    if (passcode.isNotEmpty) {
      // Logic to create a new room with the passcode
      print('Creating room with passcode: $passcode');
      // After successful creation, navigate to the room
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a passcode to create a room')),
      );
    }
  }

  void _joinRoom() {
    final roomCode = _joinRoomCodeController.text.trim();
    if (roomCode.isNotEmpty) {
      // Logic to join the room with the given room code
      print('Joining room with code: $roomCode');
      // After successful joining, navigate to the room
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a room code to join')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Home', style: TextStyle(color: Colors.white)),
        // Make back button to white
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF222142),
      ),
      backgroundColor: const Color(0xFF28264F),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: [
            // Section: Create Room
             Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3861),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextField(
                      controller: _createPasscodeController,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Passcode',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: const Color(0xFF47457A),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _createRoom,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('CREATE'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 30),

            // Section: Join Room
            Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3861),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Join Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _joinRoomCodeController,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Room Code',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: const Color(0xFF47457A),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _joinRoom,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('JOIN'),
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
import 'package:flutter/material.dart';

class PlayerListItem extends StatefulWidget {
  final String displayName;
  final String username;
  final bool isHost;

  const PlayerListItem({
    super.key,
    required this.displayName,
    required this.username,
    this.isHost = false,
  });

  @override
  State<PlayerListItem> createState() => _PlayerListItemState();
}

class _PlayerListItemState extends State<PlayerListItem> {
  // You can add any internal state variables here if needed in the future

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          SizedBox(width: 20,),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey, // Placeholder avatar color
            // You can add backgroundImage property here to load actual avatars
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isHost ? '${widget.displayName} (Host)' : widget.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@${widget.username}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
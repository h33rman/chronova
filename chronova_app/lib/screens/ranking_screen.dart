import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final rankings = [
      {
        'rank': 1,
        'name': 'PlayerOne',
        'score': 2450,
        'avatar': Icons.emoji_events,
      },
      {
        'rank': 2,
        'name': 'GamerX',
        'score': 2100,
        'avatar': Icons.sports_esports,
      },
      {
        'rank': 3,
        'name': 'NovaStar',
        'score': 1980,
        'avatar': Icons.star,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ranking",
          style: TextStyle(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Container(
        color: colorScheme.surface,
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: rankings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = rankings[index];
            return Card(
              color: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  child: Icon(
                    item['avatar'] as IconData,
                    color: colorScheme.onPrimary,
                  ),
                ),
                title: Text(
                  '${item['rank']}. ${item['name']}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '${item['score']} pts',
                  style: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
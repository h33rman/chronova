import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final newsItems = [
      {
        'title': 'Chronova 2.0 Released!',
        'subtitle': 'Discover new features and improvements in the latest update.',
      },
      {
        'title': 'Upcoming Tournament',
        'subtitle': 'Register now for the Chronova Spring Cup 2024!',
      },
      {
        'title': 'Patch Notes',
        'subtitle': 'Balance changes and bug fixes in version 1.9.5.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Container(
        color: colorScheme.surface,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: newsItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = newsItems[index];
            return Card(
              color: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                title: Text(
                  item['title']!,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  item['subtitle']!,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                leading: Icon(Icons.article, color: colorScheme.secondary),
              ),
            );
          },
        ),
      ),
    );
  }
}
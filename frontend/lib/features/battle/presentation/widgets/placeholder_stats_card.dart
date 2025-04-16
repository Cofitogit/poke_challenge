import 'package:flutter/material.dart';
import 'package:frontend/features/battle/presentation/widgets/placeholder_stat_bar.dart';

class PlaceholderStatsCard extends StatelessWidget {
  const PlaceholderStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 65, 65, 65).withValues(red: 158, green: 158, blue: 158, alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            const Icon(Icons.help_outline, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Who will be your opponent?',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Divider(
              color: Colors.grey[300],
              height: 1,
            ),
            const SizedBox(height: 8),
            const PlaceholderStatBar(),
            const SizedBox(height: 8),
            const PlaceholderStatBar(),
            const SizedBox(height: 8),
            const PlaceholderStatBar(),
            const SizedBox(height: 8),
            const PlaceholderStatBar(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

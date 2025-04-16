import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/proxied_cached_image.dart';
import 'package:frontend/features/battle/domain/entities/pokemon.dart';
import 'package:frontend/features/battle/presentation/widgets/stat_bar.dart';

class PokemonStatsCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonStatsCard({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 8,
                    child: ProxiedCachedImage(
                      imageUrl: pokemon.image,
                      height: double.infinity,
                      errorWidget: (context, url, error) => const Icon(Icons.pets, size: 60),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              height: 1,
            ),
            const SizedBox(height: 8),
            StatBar(label: 'HP', value: pokemon.hp, maxValue: 7),
            const SizedBox(height: 8),
            StatBar(label: 'Attack', value: pokemon.attack, maxValue: 7),
            const SizedBox(height: 8),
            StatBar(label: 'Defense', value: pokemon.defense, maxValue: 7),
            const SizedBox(height: 8),
            StatBar(label: 'Speed', value: pokemon.speed, maxValue: 7),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

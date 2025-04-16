import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../../../core/widgets/proxied_cached_image.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isSelected;
  final VoidCallback? onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 65, 65, 65).withValues(red: 158, green: 158, blue: 158, alpha: 0.5),
              spreadRadius: isSelected ? 3 : 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: ProxiedCachedImage(
                  imageUrl: pokemon.image,
                  height: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons.image_not_supported, size: 80),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

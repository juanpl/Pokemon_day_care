import 'package:flutter/material.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonEntity pokemon;
  final VoidCallback onStarPressed;

  const PokemonCardWidget({
    super.key,
    required this.pokemon,
    required this.onStarPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(pokemon.sprite, width: 120, height: 120),
                  SizedBox(
                    width: 80,
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              onPressed: onStarPressed,
              icon: Icon(
                Icons.star,
                color: pokemon.isOnHonorRoll ? Colors.orange : Colors.grey,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

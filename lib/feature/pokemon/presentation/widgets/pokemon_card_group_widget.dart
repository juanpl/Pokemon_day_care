import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_day_care/core/router/list_routes.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_room_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/widgets/pokemon_card_widget.dart';

class PokemonCardGroup extends StatelessWidget {
  final PokemonRoomEntity room;
  final void Function(PokemonEntity pokemon) onStarPressed;

  const PokemonCardGroup({
    super.key,
    required this.room,
    required this.onStarPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(room.roomName, style: const TextStyle(fontSize: 20)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: (room.pokemons.length > 5 ? 5 : room.pokemons.length) + 1,
          itemBuilder: (context, index) {
            final visibleCount = room.pokemons.length > 5
                ? 5
                : room.pokemons.length;
            final isLastItem = index == visibleCount;
            if (!isLastItem) {
              final pokemon = room.pokemons[index];
              return PokemonCardWidget(
                pokemon: pokemon,
                onStarPressed: () => onStarPressed(pokemon),
              );
            }
            return GestureDetector(
              child: const Card(child: Icon(Icons.more_horiz)),
              onTap: () {
                context.pushNamed(
                  ListRoutes.room.name,
                  pathParameters: {'id': room.roomName},
                );
              },
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/pokemon_on_honor_roll_controller.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/pokemon_rooms_controller.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/widgets/pokemon_card_widget.dart';

class PokemonRoomScreen extends ConsumerWidget {
  final String roomName;

  const PokemonRoomScreen({super.key, required this.roomName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(pokemonRoomsControllerProvider);

    ref.listen(pokemonOnHonorRollControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(roomName)),
      body: roomsAsync.when(
        data: (rooms) {
          final room = rooms.firstWhere((room) => room.roomName == roomName);
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: room.pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = room.pokemons[index];
              return PokemonCardWidget(
                pokemon: pokemon,
                onStarPressed: () => ref
                    .read(pokemonOnHonorRollControllerProvider.notifier)
                    .chosenPokemon(pokemon),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Ocurrió un error: $error')),
      ),
    );
  }
}

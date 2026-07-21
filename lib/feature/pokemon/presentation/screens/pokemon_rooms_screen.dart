import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/pokemon_on_honor_roll_controller.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/pokemon_rooms_controller.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/select_pokemon_generation_controller.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/widgets/drop_down_generations_menu_widget.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/widgets/pokemon_card_group_widget.dart';

class PokemonRoomsScreen extends ConsumerWidget {
  const PokemonRoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGeneration = ref.watch(selectedPokemonGenerationProvider);
    final roomsAsync = ref.watch(pokemonRoomsControllerProvider);

    ref.listen(pokemonOnHonorRollControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DropDownGenerationsMenuWidget(
              selectedGeneration: selectedGeneration,
              onGenerationChanged: (generation) {
                ref
                    .read(selectedPokemonGenerationProvider.notifier)
                    .selectGeneration(generation);
              },
            ),
            roomsAsync.when(
              data: (rooms) => Column(
                children: rooms
                    .map(
                      (room) => PokemonCardGroup(
                        room: room,
                        onStarPressed: (pokemon) => ref
                            .read(pokemonOnHonorRollControllerProvider.notifier)
                            .chosenPokemon(pokemon),
                      ),
                    )
                    .toList(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('Ocurrió un error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

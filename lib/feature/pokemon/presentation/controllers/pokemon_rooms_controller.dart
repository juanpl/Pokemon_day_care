import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/core/constant/pokemon_generations_enum.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_room_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/pokemon_provider.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/select_pokemon_generation_controller.dart';

final pokemonRoomsControllerProvider =
    AsyncNotifierProvider<PokemonRoomsController, List<PokemonRoomEntity>>(
      PokemonRoomsController.new,
    );

class PokemonRoomsController extends AsyncNotifier<List<PokemonRoomEntity>> {
  @override
  Future<List<PokemonRoomEntity>> build() async {
    final generation = ref.watch(selectedPokemonGenerationProvider);
    final createPokemonRooms = ref.watch(createPokemonRoomsProvider);
    return createPokemonRooms(generation: generation.value);
  }
}

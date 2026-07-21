import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/pokemon_provider.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/controllers/pokemon_rooms_controller.dart';

final pokemonOnHonorRollControllerProvider = AsyncNotifierProvider<PokemonOnHonorRollController, bool>(
  PokemonOnHonorRollController.new,
);

class PokemonOnHonorRollController extends AsyncNotifier<bool> {
  @override
  bool build() => false;

  Future<void> chosenPokemon(PokemonEntity pokemon) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (pokemon.isOnHonorRoll) {
        final deleteHonorRollPokemon = ref.read(deletePokemonInHonorRollUseCaseProvider);
        await deleteHonorRollPokemon(pokemonId: pokemon.id);
        return false;
      }

      final addHonorRollPokemon = ref.read(savePokemonInHonorRollUseCaseProvider);
      await addHonorRollPokemon(pokemon: pokemon);
      return true;
    });
    ref.invalidate(pokemonRoomsControllerProvider);
  }
}
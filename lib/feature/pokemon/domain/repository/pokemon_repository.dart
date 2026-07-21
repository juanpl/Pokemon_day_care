import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';

abstract interface class PokemonRepository {
  Future<List<PokemonEntity>> getPokemonList({required String generation});
  Future<void> savePokemonToTheHonorRoll({required PokemonEntity pokemon});
  Future<void> deletePokemonInTheHonorRoll({required int pokemonId});
  Future<List<PokemonEntity>> getHonorRollPokemons();
}

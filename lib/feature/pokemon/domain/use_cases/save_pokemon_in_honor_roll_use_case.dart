import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';

class SavePokemonInHonorRollUseCase {
  final PokemonRepository _pokemonRepository;

  SavePokemonInHonorRollUseCase(this._pokemonRepository);

  Future<void> call({required PokemonEntity pokemon}) async {
    return await _pokemonRepository.savePokemonToTheHonorRoll(pokemon: pokemon);
  }
}

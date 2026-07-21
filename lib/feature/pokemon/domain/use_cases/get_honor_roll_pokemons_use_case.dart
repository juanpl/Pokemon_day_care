import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';

class GetHonorRollPokemonsUseCase {
  final PokemonRepository _pokemonRepository;
  
  GetHonorRollPokemonsUseCase(this._pokemonRepository);

  Future<List<PokemonEntity>> call() async {
    try {
      return await _pokemonRepository.getHonorRollPokemons();
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-03UC',
        stackTrace: s,
        errorMessage:
            'Tuvimos oteniendo los pokemones de la BD local',
      );
    }
    
  }
  
}
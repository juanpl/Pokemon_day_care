import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';

class DeletePokemonInHonorRollUseCase {
  final PokemonRepository _pokemonRepository;

  DeletePokemonInHonorRollUseCase(this._pokemonRepository);

  Future<void> call({required int pokemonId}) async {
    try {
      await _pokemonRepository.deletePokemonInTheHonorRoll(pokemonId: pokemonId);
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-02UC',
        stackTrace: s,
        errorMessage:
            'Tuvimos problemas borrando el pokemon en la base de datos',
      );
    }
  }
}

import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';

class GetPokemonListUseCase {
  final PokemonRepository _repository;

  GetPokemonListUseCase(this._repository);

  Future<List<PokemonEntity>> call({required String generation}) {
    return _repository.getPokemonList(generation: generation);
  }
}

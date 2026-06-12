import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImp implements PokemonRepository {
  @override
  Future<List<PokemonEntity>> getPokemonList({required String generation}) {
    throw UnimplementedError();
  }
}

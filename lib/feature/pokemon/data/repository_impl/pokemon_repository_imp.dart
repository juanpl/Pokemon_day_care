import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/model/pokemon_model.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repository/pokemon_repository.dart';

class PokemonRepositoryImp implements PokemonRepository {

  final PokemonRemoteDatasource _pokemonRemoteDatasource;

  PokemonRepositoryImp(this._pokemonRemoteDatasource);
  
  @override
  Future<List<PokemonEntity>> getPokemonList({required String generation}) async{
    try {
      final data = await _pokemonRemoteDatasource.getPokemonList(generation);
      final List<Map<String, dynamic>>pokemonJson = data['gen3_species'];
      final List<PokemonModel> pokemonModel = pokemonJson.map((json)=>PokemonModel.fromJson(json)).toList();
      final List<PokemonEntity> pokemonList = pokemonModel.map((model)=>PokemonEntity.fromModel(model)).toList();
      return pokemonList;
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-1M',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas obteniendo los pokemons',
      );
    }
  }
}

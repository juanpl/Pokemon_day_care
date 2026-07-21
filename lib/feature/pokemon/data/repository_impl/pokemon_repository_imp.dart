import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_local_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/model/pokemon_model.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repository/pokemon_repository.dart';

class PokemonRepositoryImp implements PokemonRepository {
  final PokemonRemoteDatasource _pokemonRemoteDatasource;
  final PokemonLocalDatasource _pokemonLocalDatasource;

  PokemonRepositoryImp(
    this._pokemonRemoteDatasource,
    this._pokemonLocalDatasource,
  );

  @override
  Future<List<PokemonEntity>> getPokemonList({
    required String generation,
  }) async {
    try {
      final data = await _pokemonRemoteDatasource.getPokemonList(generation);
      final pokemonJson = (data['gen3_species'] as List)
          .cast<Map<String, dynamic>>();
      final List<PokemonModel> pokemonModel = pokemonJson
          .map((json) => PokemonModel.fromRemoteDataSourceJson(json))
          .toList();
      final List<PokemonEntity> pokemonList = pokemonModel
          .map((model) => PokemonEntity.fromModel(model))
          .toList();
      return pokemonList;
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-01M',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas obteniendo los pokemons del graph',
      );
    }
  }

  @override
  Future<List<PokemonEntity>> getHonorRollPokemons() async {
    try {
      final pokemonJsonList = await _pokemonLocalDatasource.getAllPokemons();
      final pokemonModelList = pokemonJsonList.map((pokemonJson)=>PokemonModel.fromLocalDataSourceJson(pokemonJson)).toList();
      final pokemonEntityList = pokemonModelList.map((pokemonModel)=>PokemonEntity.fromModel(pokemonModel)).toList();
      return pokemonEntityList;
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-02M',
        stackTrace: s,
        errorMessage:
            'Tuvimos problemas obteniendo los pokemons de la BD local',
      );
    }
  }

  @override
  Future<void> savePokemonToTheHonorRoll({
    required PokemonEntity pokemon,
  }) async {
    try {
      final pokemonModel = PokemonModel.fromEntity(pokemon);
      final pokemonJson = pokemonModel.toJson();
      await _pokemonLocalDatasource.savePokemon(pokemonJson);
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-03M',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas guardando el pokemon en DB',
      );
    }
  }

  @override
  Future<void> deletePokemonInTheHonorRoll({required int pokemonId}) async{
    try {
      await _pokemonLocalDatasource.deletePokemon(pokemonId.toString());
    } catch (e,s) {
      throw CustomException(
        error: e,
        errorCode: '01-04M',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas obteniendo los pokemons',
      );
    }
  }
}

import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/core/utils/graphql/queries.dart';

class PokemonRemoteDatasource {
  final GraphqlClient _client;

  PokemonRemoteDatasource(this._client);

  Future<Map<String, dynamic>> getPokemonList(String generation) async {
    try {
      return await _client.query(
        query: pokemonListQuery,
        variables: {'generation': generation},
      );
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-1DS',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas obteniendo los pokemons',
      );
    }
  }
}

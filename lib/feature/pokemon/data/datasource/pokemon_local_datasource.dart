import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/core/utils/sembast/sembast_client.dart';

class PokemonLocalDatasource {
  final SembastClient _sembastClient;

  PokemonLocalDatasource(this._sembastClient);

  Future<void> savePokemon(Map<String, dynamic> pokemon) async {
    try {
      await _sembastClient.put(
        'pokemon_hall_of_fame_chart',
        pokemon['id'].toString(),
        pokemon,
      );
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-2DS',
        stackTrace: s,
        errorMessage:
            'Tuvimos problemas guardando el pokemon en la base de datos',
      );
    }
  }

  Future<void> deletePokemon(String key) async {
    try {
      await _sembastClient.delete('pokemon_hall_of_fame_chart', key);
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-3DS',
        stackTrace: s,
        errorMessage:
            'Tuvimos problemas borrando el pokemon en la base de datos',
      );
    }
  }

  Future<List<Map<String, dynamic>>> getAllPokemons() async {
    try {
      return await _sembastClient.getAll('pokemon_hall_of_fame_chart');
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-4DS',
        stackTrace: s,
        errorMessage:
            'Tuvimos problemas obteninendo los pokemones de la base de datos',
      );
    }
  }
}

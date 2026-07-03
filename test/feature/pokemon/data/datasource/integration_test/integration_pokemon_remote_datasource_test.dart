import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';

const String _pokeApiGraphqlUrl = 'https://beta.pokeapi.co/graphql/v1beta';

void main() {
  late PokemonRemoteDatasource datasource;

  setUp(() {
    datasource = PokemonRemoteDatasource(GraphqlClient(_pokeApiGraphqlUrl));
  });

  group('PokemonRemoteDatasource integration', () {
    test(
      'getPokemonList trae la lista real de pokemons para una generacion valida',
      () async {
        final result = await datasource.getPokemonList('generation-i');

        expect(result, isNotEmpty);

        final species = result['gen3_species'] as List<dynamic>;
        expect(species, isNotEmpty);

        final bulbasaur = species.first as Map<String, dynamic>;
        expect(bulbasaur['name'], 'bulbasaur');
        expect(bulbasaur['id'], 1);

        final pokemons = bulbasaur['pokemon_v2_pokemons'] as List<dynamic>;
        expect(pokemons, isNotEmpty);

        final pokemon = pokemons.first as Map<String, dynamic>;
        final types = pokemon['pokemon_v2_pokemontypes'] as List<dynamic>;
        expect(types, isNotEmpty);

        final sprites = pokemon['pokemon_v2_pokemonsprites'] as List<dynamic>;
        expect(sprites, isNotEmpty);
      },
    );

    test(
      'getPokemonList retorna una lista vacia para una generacion inexistente',
      () async {
        final result = await datasource.getPokemonList('generation-inexistente');

        final species = result['gen3_species'] as List<dynamic>;
        expect(species, isEmpty);
      },
    );
  });
}

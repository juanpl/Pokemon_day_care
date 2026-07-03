import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/model/pokemon_model.dart';

const String _pokeApiGraphqlUrl = 'https://beta.pokeapi.co/graphql/v1beta';

void main() {
  late PokemonRemoteDatasource datasource;

  setUp(() {
    datasource = PokemonRemoteDatasource(GraphqlClient(_pokeApiGraphqlUrl));
  });

  group('PokemonModel integration', () {
    test(
      'PokemonModel.fromJson parsea correctamente la respuesta real de la API para bulbasaur',
      () async {
        final result = await datasource.getPokemonList('generation-i');
        final species = result['gen3_species'] as List<dynamic>;
        final bulbasaurJson = species.first as Map<String, dynamic>;

        final model = PokemonModel.fromJson(bulbasaurJson);

        expect(model.name, 'bulbasaur');
        expect(model.id, 1);
        expect(model.types, containsAll(['grass', 'poison']));
        expect(model.sprite, isNotEmpty);
        expect(Uri.tryParse(model.sprite)?.isAbsolute, isTrue);
      },
    );
  });
}

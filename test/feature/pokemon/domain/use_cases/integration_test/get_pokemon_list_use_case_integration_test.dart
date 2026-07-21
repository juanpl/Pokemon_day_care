import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/core/utils/sembast/sembast_client.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_local_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/repository_impl/pokemon_repository_imp.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_pokemon_list_use_case.dart';

const String _pokeApiGraphqlUrl = 'https://beta.pokeapi.co/graphql/v1beta';

void main() {
  late GetPokemonListUseCase useCase;

  setUp(() {
    final datasource = PokemonRemoteDatasource(
      GraphqlClient(_pokeApiGraphqlUrl),
    );
    final localDataSource = PokemonLocalDatasource(
      SembastClient()
    );
    final repository = PokemonRepositoryImp(datasource, localDataSource);
    useCase = GetPokemonListUseCase(repository);
  });

  group('GetPokemonListUseCase integration', () {
    test(
      'trae la lista real de pokemons para una generacion valida',
      () async {
        final result = await useCase(generation: 'generation-i');

        expect(result, isNotEmpty);

        final bulbasaur = result.first;
        expect(bulbasaur.name, 'bulbasaur');
        expect(bulbasaur.id, 1);
        expect(bulbasaur.types, containsAll(['grass', 'poison']));
        expect(bulbasaur.sprite, isNotEmpty);
        expect(Uri.tryParse(bulbasaur.sprite)?.isAbsolute, isTrue);
      },
    );

    test(
      'retorna una lista vacia para una generacion inexistente',
      () async {
        final result = await useCase(generation: 'generation-inexistente');

        expect(result, isEmpty);
      },
    );
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/core/utils/sembast/sembast_client.dart';

const _pokeApiGraphqlUrl = 'https://beta.pokeapi.co/graphql/v1beta';

final graphqlClientProvider = Provider<GraphqlClient>((ref) {
  return GraphqlClient(_pokeApiGraphqlUrl);
});

final sembastClientProvider = Provider<SembastClient>((ref) {
  return SembastClient();
});

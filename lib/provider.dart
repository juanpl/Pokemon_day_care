import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/core/utils/graphql/graphql_client.dart';
import 'package:pokemon_day_care/core/utils/sembast/sembast_client.dart';

final graphqlClientProvider = Provider<GraphqlClient>((ref) {
  return GraphqlClient();
});

final sembastClientProvider = Provider<SembastClient>((ref) {
  return SembastClient();
});

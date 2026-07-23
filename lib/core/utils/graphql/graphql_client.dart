import 'package:graphql/client.dart';

const _pokeApiGraphqlUrl = 'https://beta.pokeapi.co/graphql/v1beta';
class GraphqlClient {
  
  final GraphQLClient _client;

  GraphqlClient()
    : _client = GraphQLClient(
        link: HttpLink(_pokeApiGraphqlUrl),
        cache: GraphQLCache(),
      );

  Future<Map<String, dynamic>> query({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        variables: variables ?? const {},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return result.data as Map<String, dynamic>;
  }
}

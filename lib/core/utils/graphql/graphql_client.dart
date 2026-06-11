import 'package:dio/dio.dart';

class GraphqlClient {
  final Dio _dio;

  GraphqlClient(String baseUrl)
    : _dio = Dio(
        BaseOptions(baseUrl: baseUrl, contentType: 'application/json'),
      );

  Future<Map<String, dynamic>> query({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    final response = await _dio.post(
      '',
      data: {'query': query, 'variables': ?variables},
    );

    final body = response.data as Map<String, dynamic>;

    if (body['errors'] != null) {
      throw Exception(body['errors']);
    }

    return body['data'] as Map<String, dynamic>;
  }
}

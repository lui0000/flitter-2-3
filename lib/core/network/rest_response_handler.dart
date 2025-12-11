import 'package:dio/dio.dart';

class RestResponseHandler {
  static T handleResponse<T>(
    Response response,
    T Function(dynamic) fromJson,
  ) {
    switch (response.statusCode) {
      case 200:
        return fromJson(response.data);
      case 201:
        return fromJson(response.data);
      case 204:
        throw Exception('No content');
      case 400:
        throw Exception('Bad request: ${response.data}');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Resource not found');
      case 429:
        throw Exception('Too many requests');
      case 500:
        throw Exception('Internal server error');
      case 503:
        throw Exception('Service unavailable');
      default:
        throw Exception('Unknown error: ${response.statusCode}');
    }
  }

  static List<T> handleListResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => fromJson(json as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to load data: ${response.statusCode}');
  }

  static void handleDeleteResponse(Response response) {
    if (response.statusCode == 204 || response.statusCode == 200) {
      return;
    }
    throw Exception('Failed to delete resource: ${response.statusCode}');
  }
}


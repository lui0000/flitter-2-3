import 'package:dio/dio.dart';

class VersionedApiClient {
  final Dio dio;
  final int apiVersion;

  VersionedApiClient({
    required String baseUrl,
    required this.apiVersion,
  }) : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: '$baseUrl/v$apiVersion',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.myapi.v$apiVersion+json',
      },
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await dio.patch(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await dio.delete(path);
  }
}


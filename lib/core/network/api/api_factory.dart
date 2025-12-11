import 'package:dio/dio.dart';
import '../interceptors/logging_interceptor.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_handler_interceptor.dart';
import 'products_api.dart';
import 'orders_api.dart';
import 'jsonplaceholder_api.dart';
import 'github_api.dart';
import '../../di/dependency_container.dart';
import '../dio_client_with_interceptors.dart';

class ApiFactory {
  static const String _baseUrl = 'https://api.example.com/api/v1';
  static const String _apiKey = 'YOUR_API_KEY';

  late final Dio _dio;
  late final Dio _publicDio;
  late final ProductsApi _productsApi;
  late final OrdersApi _ordersApi;
  late final JsonPlaceholderApi _jsonPlaceholderApi;
  late final GithubApi _githubApi;

  ApiFactory({String? baseUrl}) {
    _dio = _createDio(baseUrl ?? _baseUrl, requiresAuth: true);
    _publicDio = _createDio(baseUrl ?? _baseUrl, requiresAuth: false);
    _productsApi = ProductsApi(_dio, baseUrl: baseUrl ?? _baseUrl);
    _ordersApi = OrdersApi(_dio, baseUrl: baseUrl ?? _baseUrl);
    _jsonPlaceholderApi = JsonPlaceholderApi(_publicDio);
    _githubApi = GithubApi(_publicDio);
  }

  Dio _createDio(String baseUrl, {bool requiresAuth = false}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    if (requiresAuth) {
      dio.interceptors.add(AuthInterceptor(_apiKey));
    }
    
    dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorHandlerInterceptor(),
    ]);

    return dio;
  }

  ProductsApi get productsApi => _productsApi;
  OrdersApi get ordersApi => _ordersApi;
  JsonPlaceholderApi get jsonPlaceholderApi => _jsonPlaceholderApi;
  GithubApi get githubApi => _githubApi;
}


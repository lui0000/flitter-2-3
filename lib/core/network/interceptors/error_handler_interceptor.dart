import 'package:dio/dio.dart';
import '../exceptions/network_exception.dart';

class ErrorHandlerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: TimeoutException(),
        ));
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode != null) {
          if (statusCode == 400) {
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: BadRequestException(
                'Bad request',
                err.response?.data,
              ),
            ));
          } else if (statusCode == 401) {
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: UnauthorizedException(
                'Unauthorized',
                err.response?.data,
              ),
            ));
          } else if (statusCode >= 500) {
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: ServerException(
                'Server error',
                err.response?.data,
              ),
            ));
          }
        }
        break;

      case DioExceptionType.connectionError:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: NetworkException('No internet connection'),
        ));
        break;

      default:
        handler.reject(err);
    }
  }
}


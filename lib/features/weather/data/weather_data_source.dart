import '../../../core/network/dio_client_with_interceptors.dart';
import 'models/weather_dto.dart';

class WeatherDataSource {
  final DioClientWithInterceptors dioClient;

  WeatherDataSource(this.dioClient);

  Future<WeatherDTO> getCurrentWeather({
    required String city,
    String units = 'metric',
    String lang = 'ru',
  }) async {
    final response = await dioClient.get(
      '/weather',
      queryParameters: {
        'q': city,
        'units': units,
        'lang': lang,
      },
    );

    return WeatherDTO.fromJson(response.data);
  }

  Future<ForecastDTO> getFiveDayForecast({
    required String city,
    String units = 'metric',
    String lang = 'ru',
  }) async {
    final response = await dioClient.get(
      '/forecast',
      queryParameters: {
        'q': city,
        'units': units,
        'lang': lang,
      },
    );

    return ForecastDTO.fromJson(response.data);
  }
}


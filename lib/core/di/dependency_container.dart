import '../network/dio_client_with_interceptors.dart';
import '../../features/weather/data/weather_data_source.dart';
import '../../features/weather/use_cases/get_weather_use_case.dart';

class DependencyContainer {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'YOUR_API_KEY_HERE';

  late final DioClientWithInterceptors _dioClient;
  late final WeatherDataSource _weatherDataSource;
  late final GetWeatherUseCase _getWeatherUseCase;

  DependencyContainer() {
    _dioClient = _createDioClient();
    _weatherDataSource = _createWeatherDataSource();
    _getWeatherUseCase = GetWeatherUseCase(_weatherDataSource);
  }

  DioClientWithInterceptors _createDioClient() {
    return DioClientWithInterceptors(
      baseUrl: _baseUrl,
      apiKey: _apiKey,
    );
  }

  WeatherDataSource _createWeatherDataSource() {
    return WeatherDataSource(_dioClient);
  }

  WeatherDataSource provideWeatherDataSource() => _weatherDataSource;
  GetWeatherUseCase provideGetWeatherUseCase() => _getWeatherUseCase;
}


import '../data/weather_data_source.dart';
import '../data/mappers/weather_mapper.dart';
import '../domain/models/weather_model.dart';

class GetWeatherUseCase {
  final WeatherDataSource dataSource;

  GetWeatherUseCase(this.dataSource);

  Future<WeatherModel> execute(String city) async {
    if (city.trim().isEmpty) {
      throw Exception('City name cannot be empty');
    }

    final weatherDTO = await dataSource.getCurrentWeather(city: city);
    final weatherModel = weatherDTO.toModel();

    if (weatherModel.isExtremeWeather) {
      print('⚠️ Warning: Extreme weather conditions detected!');
    }

    return weatherModel;
  }
}


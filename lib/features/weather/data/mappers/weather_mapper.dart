import '../../domain/models/weather_model.dart';
import '../models/weather_dto.dart';

extension WeatherDTOMapper on WeatherDTO {
  WeatherModel toModel() {
    return WeatherModel(
      cityName: name,
      temperature: main.temp,
      feelsLike: main.feelsLike,
      description: weather.isNotEmpty ? weather.first.description : '',
      humidity: main.humidity,
      windSpeed: wind.speed,
      sunrise: DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000),
    );
  }
}


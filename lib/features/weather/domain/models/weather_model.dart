class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  String get temperatureFormatted => '${temperature.toStringAsFixed(1)}°C';

  bool get isDaytime {
    final now = DateTime.now();
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }

  bool get isExtremeWeather {
    return temperature > 35 || temperature < -20 || windSpeed > 20;
  }
}


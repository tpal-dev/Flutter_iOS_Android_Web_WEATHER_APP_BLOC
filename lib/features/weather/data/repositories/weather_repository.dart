import 'dart:convert';
import 'package:weather_app/features/weather/data/data_providers/open_weather_api.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';

abstract class WeatherRepository {
  /// Calls the https://example.com/{cityName} endpoint.
  ///
  /// Throws a [NetworkException] for all error codes.
  Future<Weather> getWeatherForCity({required String cityName});

  /// Calls the https://example.com/{gpsLocation} endpoint.
  ///
  /// Throws a [NetworkException] for all error codes.
  Future<Weather> getWeatherForCurrentLocation(
      {required int latitude, required int longitude});
}

class WeatherRepositoryOpenWeatherMapImpl implements WeatherRepository {
  final WeatherAPI weatherAPI = OpenWeatherAPI();

  @override
  Future<Weather> getWeatherForCity({required String cityName}) async {
    final String jsonWeather =
        await weatherAPI.getJsonWeatherForCity(cityName: cityName);
    return _getWeatherFromUrl(jsonWeather);
  }

  @override
  Future<Weather> getWeatherForCurrentLocation(
      {required int latitude, required int longitude}) async {
    final String jsonWeather =
        await weatherAPI.getJsonWeatherForCurrentLocation(
            latitude: latitude, longitude: longitude);
    return _getWeatherFromUrl(jsonWeather);
  }

  Weather _getWeatherFromUrl(String jsonWeather) {
    return Weather.fromJson(jsonDecode(jsonWeather));
  }
}

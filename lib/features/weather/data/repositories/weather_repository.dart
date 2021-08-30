import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/features/weather/data/data_providers/open_weather_api.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherForCity({required String cityName});
  Future<Weather> getWeatherForCurrentLocation(
      {required int latitude, required int longitude});
}

class WeatherRepositoryOpenWeatherMapImpl implements WeatherRepository {
  final WeatherAPI weatherAPI = OpenWeatherAPI();

  @override
  Future<Weather> getWeatherForCity({required String cityName}) async {
    final Response rawWeather =
        await weatherAPI.getRawWeatherForCity(cityName: cityName);
    return _getWeatherFromUrl(rawWeather);
  }

  @override
  Future<Weather> getWeatherForCurrentLocation(
      {required int latitude, required int longitude}) async {
    final Response rawWeather =
        await weatherAPI.getRawWeatherForCurrentLocation(
            latitude: latitude, longitude: longitude);
    return _getWeatherFromUrl(rawWeather);
  }

  Weather _getWeatherFromUrl(Response rawWeather) =>
      Weather.fromJson(jsonDecode(rawWeather.body)['weather']);
}

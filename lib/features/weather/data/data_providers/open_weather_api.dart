import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exceptions.dart';

abstract class WeatherAPI {
  Future<String> getJsonWeatherForCity({required String cityName});
  Future<String> getJsonWeatherForCurrentLocation(
      {required double latitude, required double longitude});
}

class OpenWeatherAPI implements WeatherAPI {
  final http.Client client = http.Client();
  static const _apiKey = '2f601ff27d95ea7a9d5f5a7b0db8822c';

  @override
  Future<String> getJsonWeatherForCity({required String cityName}) =>
      _getJsonWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric');

  @override
  Future<String> getJsonWeatherForCurrentLocation(
          {required double latitude, required double longitude}) =>
      _getJsonWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric');

  Future<String> _getJsonWeatherFromUrl(String url) async {
    final Uri uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        'X-API-Key': _apiKey,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw BadRequestException();
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}

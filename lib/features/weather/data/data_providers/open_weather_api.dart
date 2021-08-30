import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class WeatherAPI {
  Future<Response> getRawWeatherForCity({required String cityName});
  Future<Response> getRawWeatherForCurrentLocation(
      {required int latitude, required int longitude});
}

class OpenWeatherAPI implements WeatherAPI {
  final http.Client client = http.Client();
  static const _apiKey = '2f601ff27d95ea7a9d5f5a7b0db8822c';

  @override
  Future<Response> getRawWeatherForCity({required String cityName}) =>
      _getRawWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName');

  @override
  Future<Response> getRawWeatherForCurrentLocation(
          {required int latitude, required int longitude}) =>
      _getRawWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude');

  Future<Response> _getRawWeatherFromUrl(String url) async {
    final Uri uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        'X-API-Key': _apiKey,
      },
    );
    return response;
  }
}

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class WeatherAPI {
  Future<Response> getRawWeatherForCity(String city);
  Future<Response> getRawWeatherForCurrentLocation(int lat, int lon);
}

class OpenWeatherAPI implements WeatherAPI {
  final httpClient = http.Client();

  @override
  Future<Response> getRawWeatherForCity(String city) => _getRawWeatherFromUrl(
      'https://api.openweathermap.org/data/2.5/weather?q=$city');

  @override
  Future<Response> getRawWeatherForCurrentLocation(int lat, int lon) =>
      _getRawWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon');

  Future<Response> _getRawWeatherFromUrl(String url) async {
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        'X-API-Key': '2f601ff27d95ea7a9d5f5a7b0db8822c',
      },
    );
    return response;
  }
}

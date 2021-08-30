import 'package:http/http.dart' as http;

abstract class WeatherAPI {
  Future<String> getJsonWeatherForCity({required String cityName});
  Future<String> getJsonWeatherForCurrentLocation(
      {required int latitude, required int longitude});
}

class OpenWeatherAPI implements WeatherAPI {
  final http.Client client = http.Client();
  static const _apiKey = '2f601ff27d95ea7a9d5f5a7b0db8822c';

  @override
  Future<String> getJsonWeatherForCity({required String cityName}) =>
      _getJsonWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName');

  @override
  Future<String> getJsonWeatherForCurrentLocation(
          {required int latitude, required int longitude}) =>
      _getJsonWeatherFromUrl(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude');

  Future<String> _getJsonWeatherFromUrl(String url) async {
    final Uri uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        'X-API-Key': _apiKey,
      },
    );
    return response.body;
  }
}

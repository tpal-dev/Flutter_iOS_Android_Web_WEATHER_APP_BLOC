part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherForCity extends WeatherEvent {
  const GetWeatherForCity(this.cityName);
  final String cityName;

  @override
  List<Object> get props => [cityName];
}

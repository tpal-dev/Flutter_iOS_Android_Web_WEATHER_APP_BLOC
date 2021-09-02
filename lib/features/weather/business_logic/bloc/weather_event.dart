part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForCity extends WeatherEvent {
  const GetWeatherForCity(this.cityName);

  final String cityName;

  @override
  List<Object> get props => [cityName];
}

class GetWeatherForLocation extends WeatherEvent {
  const GetWeatherForLocation();
}

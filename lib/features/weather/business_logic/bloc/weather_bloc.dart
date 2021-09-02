import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/location/location.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepository) : super(const WeatherInitial());
  final WeatherRepository _weatherRepository;
  static const _socketExceptionMessage =
      'Couldn\'t fetch weather. Is the device online?';
  static const _badRequestExceptionMessage = 'City not found.';

  Stream<WeatherState> _mapGetWeather(
    WeatherEvent event,
    Weather weather,
  ) async* {
    try {
      yield const WeatherFetchInProgress();
      yield WeatherFetchSuccess(weather: weather);
    } on BadRequestException {
      yield const WeatherFetchFailure(
          errorMessage: _badRequestExceptionMessage);
    } on SocketException {
      yield const WeatherFetchFailure(errorMessage: _socketExceptionMessage);
    } on Exception catch (e) {
      yield WeatherFetchFailure(
          errorMessage: 'Sorry, we have some problems. $e');
    }
  }

  Stream<WeatherState> _mapGetWeatherForCityToState(
      GetWeatherForCity event) async* {
    final weather =
        await _weatherRepository.getWeatherForCity(cityName: event.cityName);
    yield* _mapGetWeather(event, weather);
  }

  Stream<WeatherState> _mapGetWeatherForLocation(
    GetWeatherForLocation event,
  ) async* {
    final location = await Location.determinePosition();
    final weather = await _weatherRepository.getWeatherForCurrentLocation(
        latitude: location.latitude, longitude: location.longitude);
    yield* _mapGetWeather(event, weather);
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherForCity) {
      yield* _mapGetWeatherForCityToState(event);
    } else if (event is GetWeatherForLocation) {
      yield* _mapGetWeatherForLocation(event);
    }
  }
}

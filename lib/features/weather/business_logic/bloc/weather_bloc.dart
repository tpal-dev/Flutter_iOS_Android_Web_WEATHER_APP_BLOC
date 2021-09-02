import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/exceptions.dart';
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

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherForCity) {
      try {
        yield const WeatherFetchInProgress();
        final weather = await _weatherRepository.getWeatherForCity(
            cityName: event.cityName);
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
  }
}

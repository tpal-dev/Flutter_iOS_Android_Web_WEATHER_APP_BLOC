import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/errors.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepository) : super(const WeatherInitial());
  final WeatherRepository _weatherRepository;
  static const _networkExceptionMessage =
      'Couldn\'t fetch weather. Is the device online?';
  static const _badRequestExceptionMessage = 'Bad request. City not found.';

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherForCity) {
      try {
        yield WeatherFetchInProgress();
        final weather = await _weatherRepository.getWeatherForCity(
            cityName: event.cityName);
        yield WeatherFetchSuccess(weather: weather);
      } on NetworkException {
        yield const WeatherFetchFailure(errorMessage: _networkExceptionMessage);
      } on SocketException {
        yield const WeatherFetchFailure(errorMessage: _networkExceptionMessage);
      } on BadRequestException {
        yield const WeatherFetchFailure(
            errorMessage: _badRequestExceptionMessage);
      }
    }
  }
}

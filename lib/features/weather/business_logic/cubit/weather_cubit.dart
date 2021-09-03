import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/location/location.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherInitial());

  final WeatherRepository _weatherRepository;
  static const _socketExceptionMessage =
      'Couldn\'t fetch weather. Is the device online?';
  static const _badRequestExceptionMessage = 'City not found.';

  Future<void> getWeatherForCity(String cityName) async {
    final futureWeather =
        _weatherRepository.getWeatherForCity(cityName: cityName);
    return _getWeather(futureWeather);
  }

  Future<void> getWeatherForLocation() async {
    final location = await Location.determinePosition();
    final futureWeather = _weatherRepository.getWeatherForCurrentLocation(
        latitude: location.latitude, longitude: location.longitude);
    return _getWeather(futureWeather);
  }

  Future<void> _getWeather(Future<Weather> futureWeather) async {
    try {
      emit(const WeatherFetchInProgress());
      final weather = await futureWeather;
      emit(WeatherFetchSuccess(weather: weather));
    } on BadRequestException {
      emit(
          const WeatherFetchFailure(errorMessage: _badRequestExceptionMessage));
    } on SocketException {
      emit(const WeatherFetchFailure(errorMessage: _socketExceptionMessage));
    } on Exception catch (e) {
      emit(WeatherFetchFailure(
          errorMessage: 'Sorry, we have some problems. $e'));
    }
  }
}

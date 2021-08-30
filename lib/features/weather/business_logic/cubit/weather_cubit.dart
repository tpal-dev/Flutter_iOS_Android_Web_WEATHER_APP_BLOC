import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/errors.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  static const _networkExceptionMessage =
      'Couldn\'t fetch weather. Is the device online?';

  WeatherCubit({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherInitial());

  Future<void> getWeatherForCity(String cityName) async {
    try {
      emit(const WeatherFetchInProgress());
      final weather =
          await _weatherRepository.getWeatherForCity(cityName: cityName);
      emit(WeatherFetchSuccess(weather: weather));
    } on NetworkException {
      emit(
        const WeatherFetchFailure(errorMessage: _networkExceptionMessage),
      );
    }
  }
}

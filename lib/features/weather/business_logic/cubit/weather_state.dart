part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherFetchInProgress extends WeatherState {
  const WeatherFetchInProgress();
}

class WeatherFetchSuccess extends WeatherState {
  final Weather weather;

  const WeatherFetchSuccess({
    required this.weather,
  });

  @override
  List<Object> get props => [weather];

  @override
  String toString() {
    return 'WeatherFetchSuccess{weather: $weather}';
  }
}

class WeatherFetchFailure extends WeatherState {
  final String errorMessage;

  const WeatherFetchFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'WeatherFetchFailure{errorMessage: $errorMessage}';
  }
}

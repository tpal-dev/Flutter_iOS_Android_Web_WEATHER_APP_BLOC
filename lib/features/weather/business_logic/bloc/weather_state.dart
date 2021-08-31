part of 'weather_bloc.dart';

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
  const WeatherFetchSuccess({
    required this.weather,
  });
  final Weather weather;

  @override
  List<Object> get props => [weather];

  @override
  String toString() {
    return 'WeatherFetchSuccess{weather: $weather}';
  }
}

class WeatherFetchFailure extends WeatherState {
  const WeatherFetchFailure({
    required this.errorMessage,
  });
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'WeatherFetchFailure{errorMessage: $errorMessage}';
  }
}

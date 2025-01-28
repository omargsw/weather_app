part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherData;
  const WeatherLoadedState({required this.weatherData});

  @override
  List<Object> get props => [weatherData];
}

class WeatherErrorState extends WeatherState {
  final String message;
  final String? errorCode;

  const WeatherErrorState({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

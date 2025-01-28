part of 'weather_history_bloc.dart';

sealed class WeatherHistoryState extends Equatable {
  const WeatherHistoryState();
}

final class WeatherHistoryInitial extends WeatherHistoryState {
  @override
  List<Object> get props => [];
}

final class WeatherHistoryLoadedState extends WeatherHistoryState {
  final List<HistoryModel> weatherHistory;
  const WeatherHistoryLoadedState({required this.weatherHistory});

  @override
  List<Object> get props => [weatherHistory];
}

final class WeatherHistoryLoadingState extends WeatherHistoryState {
  @override
  List<Object> get props => [];
}

class WeatherHistoryErrorState extends WeatherHistoryState {
  final String message;
  final String? errorCode;

  const WeatherHistoryErrorState({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

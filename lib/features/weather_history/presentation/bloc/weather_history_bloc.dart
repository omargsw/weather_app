import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/features/weather_history/data/models/weather_history_model.dart';
import 'package:weather_app/features/weather_history/domain/usecases/fetch_weather_history_usecase.dart';

part 'weather_history_event.dart';
part 'weather_history_state.dart';

class WeatherHistoryBloc
    extends Bloc<WeatherHistoryEvent, WeatherHistoryState> {
  final FetchWeatherHistoryUsecase fetchWeatherHistoryUsecase;
  WeatherHistoryBloc({required this.fetchWeatherHistoryUsecase})
      : super(WeatherHistoryInitial()) {
    on<WeatherHistoryEvent>((event, emit) async {
      if (event is FetchWeatherHistoryEvent) {
        emit(WeatherHistoryLoadingState());
        final historyList = await fetchWeatherHistoryUsecase.call();
        historyList.fold(
          (failure) {
            final String errorMessage =
                AppFunctions.mapFailureToMessage(failure: failure);
            String? errorCode;
            if (failure is ServerFailure) {
              errorCode = failure.errorCode;
            }
            emit(WeatherHistoryErrorState(
                message: errorMessage, errorCode: errorCode));
          },
          (history) {
            emit(
              WeatherHistoryLoadedState(weatherHistory: history),
            );
          },
        );
      }
    });
  }
}

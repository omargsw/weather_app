import 'package:weather_app/core/utils/helpers/app_typedef.dart';
import 'package:weather_app/features/weather_history/data/models/weather_history_model.dart';
import 'package:weather_app/features/weather_history/domain/repositories/weather_history_repo.dart';

class FetchWeatherHistoryUsecase {
  final WeatherHistoryRepository weatherHistoryRepository;
  FetchWeatherHistoryUsecase({required this.weatherHistoryRepository});

  FutureEither<List<HistoryModel>> call() async =>
      weatherHistoryRepository.fetchHistory();
}

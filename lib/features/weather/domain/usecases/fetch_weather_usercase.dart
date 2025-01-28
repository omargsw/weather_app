import 'package:weather_app/core/utils/helpers/app_typedef.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repo.dart';

class FetchWeatherUsecase {
  final WeatherRepository weatherRepository;
  FetchWeatherUsecase({required this.weatherRepository});

  FutureEither<WeatherModel> call({required String cityName}) async =>
      weatherRepository.fetchWeather(cityName: cityName);
}

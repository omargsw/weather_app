import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/utils/api/api_client.dart';
import 'package:weather_app/core/utils/api/api_constants.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_expressions.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherRemoteDataSource {
  Future<WeatherModel> fetchWeather({required String cityName}) async {
    final response = await ApiClient.getData(
        url: ApiConstants.baseUrl + ApiConstants.weatherUrl,
        queryParameters: {
          "q": cityName,
          "appid": AppConstants.weatherKey,
          "units": "metric",
        });

    if (response.statusCode == 200) {
      final data = WeatherModel.fromJson(response.data);
      return data;
    } else {
      throw ServerException(
          errorMessage: response.data['message'].toString().replaceAll(
              AppExpressions.textPattern, response.statusCode.toString()));
    }
  }
}

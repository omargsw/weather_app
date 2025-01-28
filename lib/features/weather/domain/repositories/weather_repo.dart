import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../../core/utils/helpers/app_typedef.dart';

class WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepository(
      {required this.weatherRemoteDataSource, required this.networkInfo});

  FutureEither<WeatherModel> fetchWeather({required String cityName}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await weatherRemoteDataSource.fetchWeather(cityName: cityName);
        return Right(remoteUser);
      } on ServerException catch (error) {
        AppLogger.error(
            "Wather Error: Server exception: ${error.errorMessage}");
        return Left(ServerFailure(errorCode: error.errorMessage));
      } on NoDataException catch (error) {
        AppLogger.error(
            "Wather Error: No data exception: ${error.errorMessage}");
        return Left(NoDataFailure());
      } on UnknownException catch (error) {
        AppLogger.error(
            "Wather Error: Unknown exception: ${error.errorMessage}");
        return Left(UnExpectedFailure());
      } on NoInternetConnectionException catch (error) {
        AppLogger.error(
            "Wather Error: No internet connection exception: ${error.errorMessage}");
        return Left(NoInternetConnectionFailure());
      } catch (error) {
        AppLogger.error("Wather Error: Unexpected error ${error.toString()}");
        return Left(UnExpectedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}

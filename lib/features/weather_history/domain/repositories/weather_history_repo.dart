import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/features/weather_history/data/models/weather_history_model.dart';

import '../../../../core/utils/helpers/app_typedef.dart';
import '../../data/data_sources/remote/weather_history_remote_data_source.dart';

class WeatherHistoryRepository {
  final WeatherHistoryRemoteDataSource weatherHistoryRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherHistoryRepository(
      {required this.weatherHistoryRemoteDataSource,
      required this.networkInfo});

  FutureEither<List<HistoryModel>> fetchHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await weatherHistoryRemoteDataSource.fetchHistory();
        return Right(remoteUser);
      } on ServerException catch (error) {
        AppLogger.error(
            "User Info Error: Server exception: ${error.errorMessage}");
        return Left(ServerFailure(errorCode: error.errorMessage));
      } on NoDataException catch (error) {
        AppLogger.error(
            "User Info Error: No data exception: ${error.errorMessage}");
        return Left(NoDataFailure());
      } on UnknownException catch (error) {
        AppLogger.error(
            "User Info Error: Unknown exception: ${error.errorMessage}");
        return Left(UnExpectedFailure());
      } on NoInternetConnectionException catch (error) {
        AppLogger.error(
            "User Info Error: No internet connection exception: ${error.errorMessage}");
        return Left(NoInternetConnectionFailure());
      } catch (error) {
        AppLogger.error(
            "User Info Error: Unexpected error ${error.toString()}");
        return Left(UnExpectedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}

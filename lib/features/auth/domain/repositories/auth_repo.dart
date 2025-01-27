import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';

import '../../../../core/utils/helpers/app_typedef.dart';
import '../../data/data_sources/remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepository(
      {required this.authRemoteDataSource, required this.networkInfo});

  FutureEither<String> register(
      {required String email, required String password}) async {
    return performRequest(() => authRemoteDataSource
        .registerWithEmailAndPassword(email: email, password: password));
  }

  FutureEither<String> login(
      {required String email, required String password}) async {
    return performRequest(() => authRemoteDataSource.loginWithEmailAndPassword(
        email: email, password: password));
  }

  FutureEither<String> performRequest(
      Future<String?> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await request();
        return Right(remoteAuth!);
      } on ServerException catch (error) {
        AppLogger.error("Error: Server exception: ${error.errorMessage}");
        return Left(ServerFailure(errorCode: error.errorMessage));
      } on NoDataException catch (error) {
        AppLogger.error("Error: No data exception: ${error.errorMessage}");
        return Left(NoDataFailure());
      } on WrongDataException catch (error) {
        AppLogger.error("Wrong Data Failure: ${error.errorMessage}");
        return Left(WrongDataFailure(errorMessage: error.errorMessage));
      } on UnknownException catch (error) {
        AppLogger.error("Error: Unknown exception: ${error.errorMessage}");
        return Left(UnExpectedFailure());
      } on NoInternetConnectionException catch (error) {
        AppLogger.error(
            "Error: No internet connection exception: ${error.errorMessage}");
        return Left(NoInternetConnectionFailure());
      } catch (error) {
        AppLogger.error("Error: Unexpected error ${error.toString()}");
        return Left(UnExpectedFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}

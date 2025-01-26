// import 'package:dartz/dartz.dart';
// import 'package:jay_app/core/errors/exceptions.dart';
// import 'package:jay_app/core/errors/failures.dart';
// import 'package:jay_app/core/network/network_info.dart';
// import 'package:jay_app/core/utils/helpers/app_logger.dart';
// import 'package:jay_app/features/account/data/models/user_profile_model.dart';

// import '../../../../core/utils/helpers/app_typedef.dart';
// import '../../data/data_sources/remote/user_info_remote_data_source.dart';

// class UserProfileRepository {
//   final UserProfileRemoteDataSource userProfileRemoteDataSource;
//   final NetworkInfo networkInfo;

//   UserProfileRepository({required this.userProfileRemoteDataSource, required this.networkInfo});

//   FutureEither<UserProfileModel> fetchUserProfile() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final remoteUser = await userProfileRemoteDataSource.fetchUserInfo();
//         return Right(remoteUser);
//       } on ServerException catch (error) {
//         AppLogger.error("User Info Error: Server exception: ${error.errorMessage}");
//         return Left(ServerFailure(errorCode: error.errorMessage));
//       } on NoDataException catch (error) {
//         AppLogger.error("User Info Error: No data exception: ${error.errorMessage}");
//         return Left(NoDataFailure());
//       } on UnknownException catch (error) {
//         AppLogger.error("User Info Error: Unknown exception: ${error.errorMessage}");
//         return Left(UnExpectedFailure());
//       } on NoInternetConnectionException catch (error) {
//         AppLogger.error("User Info Error: No internet connection exception: ${error.errorMessage}");
//         return Left(NoInternetConnectionFailure());
//       } catch (error) {
//         AppLogger.error("User Info Error: Unexpected error ${error.toString()}");
//         return Left(UnExpectedFailure());
//       }
//     } else {
//       return Left(NoInternetConnectionFailure());
//     }
//   }
// }

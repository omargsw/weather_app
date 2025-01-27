import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/features/home/data/models/user_info_model.dart';

class UserInfoRemoteDataSource {
  Future<UserModel> getUserInfoByUuid() async {
    try {
      String uuid =
          await AppSecureStorage.getData(key: AppConstants.userID) ?? "no user";
      DocumentSnapshot<Map<String, dynamic>> document =
          await FirebaseFirestore.instance.collection('users').doc(uuid).get();

      if (document.exists && document.data() != null) {
        // Map Firestore data to UserModel
        return UserModel.fromMap(document.data()!);
      } else {
        throw ServerException(errorMessage: 'User with UUID $uuid not found.');
      }
    } catch (e) {
      AppLogger.warning('Error fetching user info: $e');
      // throw Exception('Failed to fetch user information: $e');
      throw ServerException(
          errorMessage: 'Failed to fetch user information: $e');
    }
  }
}

// import 'dart:io';

// import 'package:dio/dio.dart';


// import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/locale/app_languages.dart';
// import '../../../../../core/utils/api/api_client.dart';
// import '../../../../../core/utils/helpers/app_constants.dart';
// import '../../../../../core/utils/helpers/app_secure_storage.dart';

class HomeRemoteDataSource {
  // Future<UserProfileModel> fetchUserInfo() async {
  //   final LanguageChanging languageChanging = LanguageChanging();
  //   final String currentLang = await languageChanging.getAppLanguage();
  //   AppLogger.info("currentLang : $currentLang");
  //   final String token = await AppSecureStorage.getData(key: AppConstants.accessToken) ?? "";
  //   final response = await ApiClient.getData(
  //     url: currentLang + ApiConstants.userInfo,
  //     headers: {ApiConstants.authorization: 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     final userModel = UserProfileModel.fromJson(response.data);
  //     return userModel;
  //   } else {
  //     AppLogger.warning(response.data);
  //     throw ServerException(errorMessage: AppStrings.errorCode.tr().replaceAll(AppExpressions.textPattern, response.statusCode.toString()));
  //   }
  // }

}

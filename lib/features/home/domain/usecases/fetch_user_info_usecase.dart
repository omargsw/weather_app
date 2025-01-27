
import 'package:weather_app/core/utils/helpers/app_typedef.dart';
import 'package:weather_app/features/home/data/models/user_info_model.dart';
import 'package:weather_app/features/home/domain/repositories/user_info_repo.dart';

class FetchUserInfoUsecase {
  final UserInfoRepository userInfoRepository;
  FetchUserInfoUsecase({required this.userInfoRepository});

  FutureEither<UserModel> call() async => userInfoRepository.fetchUserInfo();
}

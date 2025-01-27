import 'package:weather_app/core/utils/helpers/app_typedef.dart';

import '../repositories/auth_repo.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  FutureEither<String> call({
    required String email,
    required String password,
  }) async =>
      authRepository.login(email: email, password: password);
}

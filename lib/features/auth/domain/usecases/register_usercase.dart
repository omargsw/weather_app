import 'package:weather_app/core/utils/helpers/app_typedef.dart';

import '../repositories/auth_repo.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});

  FutureEither<String> call({
    required String email,
    required String password,
  }) async =>
      authRepository.register(email: email, password: password);
}

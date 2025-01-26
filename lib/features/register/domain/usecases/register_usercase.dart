import 'package:weather_app/core/utils/helpers/app_typedef.dart';

import '../repositories/register_repo.dart';

class RegisterUsecase {
  final RegisterRepository registerRepository;
  RegisterUsecase({required this.registerRepository});

  FutureEither<String> call({
    required String email,
    required String password,
  }) async =>
      registerRepository.register(email: email, password: password);
}

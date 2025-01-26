part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignUpEvent extends RegisterEvent {
  final String confirmPassword;
  final String password;
  final String email;

  const SignUpEvent({
    required this.confirmPassword,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [
        confirmPassword,
        password,
        email,
      ];
}

part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginnEvent extends LoginEvent {
  const LoginnEvent();

  @override
  List<Object?> get props => [];
}

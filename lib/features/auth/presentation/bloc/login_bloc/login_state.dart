part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class SuccessLoginState extends LoginState {
  final String uuid;
  const SuccessLoginState({required this.uuid});
  @override
  List<Object> get props => [uuid];
}

class ErrorLoginState extends LoginState {
  final String message;
  final String? errorCode;
  const ErrorLoginState({required this.message, this.errorCode});
  @override
  List<Object> get props => [
        message,
        errorCode ?? "",
      ];
}

class LoadingLoginState extends LoginState {}

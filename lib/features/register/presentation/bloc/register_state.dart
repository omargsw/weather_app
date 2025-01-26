part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class SuccessSignUpState extends RegisterState {
  // final AuthModel authModel;
  const SuccessSignUpState();
  // @override
  // List<Object> get props => [authModel];
}

class ErrorSignUpState extends RegisterState {
  final String message;
  final String? errorCode;
  const ErrorSignUpState({required this.message, this.errorCode});
  @override
  List<Object> get props => [
        message,
        errorCode ?? "",
      ];
}

class LoadingSignUpState extends RegisterState {}

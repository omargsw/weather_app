part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();
}

final class UserInfoInitial extends UserInfoState {
  @override
  List<Object> get props => [];
}

class LoadingUserInfoState extends UserInfoState {
  @override
  List<Object?> get props => [];
}

class ErrorUserInfoState extends UserInfoState {
  final String message;
  final String? errorCode;

  const ErrorUserInfoState({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class LoadedUserInfoState extends UserInfoState {
  final UserModel userInfo;
  const LoadedUserInfoState({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}

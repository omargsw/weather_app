import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;

  const Failure({this.errorMessage});
}

class NoInternetConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String? errorCode;

  const ServerFailure({super.errorMessage, this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class UnExpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure {
  const WrongDataFailure({super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ServerException implements Exception {
  final String errorMessage;
  ServerException({required this.errorMessage});
}

class NoDataException implements Exception {
  final String errorMessage;
  NoDataException({required this.errorMessage});
}

class UnknownException implements Exception {
  final String errorMessage;
  UnknownException({required this.errorMessage});
}

class WrongDataException implements Exception {
  final String errorMessage;
  WrongDataException({required this.errorMessage});
}

class NoInternetConnectionException implements Exception {
  final String errorMessage;
  NoInternetConnectionException({required this.errorMessage});
}
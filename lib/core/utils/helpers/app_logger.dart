import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  AppLogger._();

  static void debug(String message) {
    _logger.d(message, stackTrace: StackTrace.empty);
  }

  static void info(String message) {
    _logger.i(message, stackTrace: StackTrace.empty);
  }

  static void warning(String message) {
    _logger.w(message, stackTrace: StackTrace.current);
  }

  static void error(dynamic message) {
    _logger.e(message, error: message);
  }

  static void verbose(String message) {
    _logger.t(message, stackTrace: StackTrace.current);
  }

  static void wtf(String message) {
    _logger.f(message, stackTrace: StackTrace.current);
  }
}

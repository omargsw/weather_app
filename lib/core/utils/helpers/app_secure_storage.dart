import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_logger.dart';

class AppSecureStorage {
  static FlutterSecureStorage? _secureStorage;

  AppSecureStorage._();

  /// Flutter Secure Storage Initialization
  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
  }

  /// GET Data
  static Future<String?> getData({required String key}) async {
    return await _secureStorage?.read(key: key);
  }

  /// Save Data
  static Future<void>? saveData({required String key, required String value}) async {
    await _secureStorage?.write(key: key, value: value);
  }

  /// Remove Data
  static Future<void>? removeData({required String key}) async {
    await _secureStorage?.delete(key: key);
  }

  static Future<void>? removeAllData() async {
    await _secureStorage?.deleteAll();
  }

  static Future<void>? removeUserCredentials() async {
    await _secureStorage?.deleteAll();
    AppLogger.debug('User Credentials has been removed successfully ✅');
  }
}

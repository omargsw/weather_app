import 'package:shared_preferences/shared_preferences.dart';

import 'app_logger.dart';

class AppCache {
  static SharedPreferences? _sharedPreferences;

  AppCache._();

  /// Shared Preferences Initialization
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// GET Data
  static dynamic getData({required String key}) {
    return _sharedPreferences?.get(key);
  }

  /// Save Data
  static Future<bool?> saveData({required String key, required dynamic value}) async {
    if (_sharedPreferences == null) return null;

    if (value is String) {
      return await _sharedPreferences?.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences?.setInt(key, value);
    } else if (value is bool) {
      return await _sharedPreferences?.setBool(key, value);
    } else if (value is double) {
      return await _sharedPreferences?.setDouble(key, value);
    } else {
      AppLogger.error('Invalid type for SharedPreferences');
      throw Exception("Invalid type for SharedPreferences");
    }
  }

  /// Remove Data
  static Future<bool?> removeData({
    required String key,
  }) async {
    return await _sharedPreferences?.remove(key);
  }

  /// Remove All Data
  static Future<bool?> removeAllData() async {
    return await _sharedPreferences?.clear();
  }
}

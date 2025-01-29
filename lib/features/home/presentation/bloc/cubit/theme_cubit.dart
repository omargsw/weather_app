import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/helpers/app_cache.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    _loadTheme();
  }

  void toggleTheme() async {
    final newTheme = !state;
    _saveTheme(newTheme);
    emit(newTheme);
  }

  Future<void> _loadTheme() async {
    final isDark = AppCache.getData(key: 'isDarkTheme') ?? false;
    emit(isDark);
  }

  Future<void> _saveTheme(bool isDark) async {
    AppCache.saveData(key: 'isDarkTheme', value: isDark);
  }
}

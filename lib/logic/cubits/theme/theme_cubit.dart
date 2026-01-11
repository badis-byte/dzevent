import 'package:dzevent/logic/cubits/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight()) {
    _loadTheme();
  }

  static const String _themeKey = 'isDarkMode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey) ?? false;
      emit(isDark ? ThemeDark() : ThemeLight());
    } catch (e) {
      print('Error loading theme: $e');
      emit(ThemeLight());
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = state is ThemeDark;
      final newTheme = !isDark;
      await prefs.setBool(_themeKey, newTheme);
      emit(newTheme ? ThemeDark() : ThemeLight());
    } catch (e) {
      print('Error toggling theme: $e');
    }
  }

  Future<void> setTheme(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDark);
      emit(isDark ? ThemeDark() : ThemeLight());
    } catch (e) {
      print('Error setting theme: $e');
    }
  }
}


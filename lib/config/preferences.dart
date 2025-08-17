import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class Preferences {
  static const _boxName = 'app_prefs';
  static const _keyThemeMode = 'theme_mode'; // system|light|dark
  static const _keyLanguage = 'language'; // system|en_US|id_ID

  static Future<void> init() async {
    await GetStorage.init(_boxName);
  }

  static final GetStorage _box = GetStorage(_boxName);

  // Theme
  static ThemeMode getThemeMode() {
    final value = _box.read<String>(_keyThemeMode) ?? 'system';
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    String v = 'system';
    if (mode == ThemeMode.light) v = 'light';
    if (mode == ThemeMode.dark) v = 'dark';
    await _box.write(_keyThemeMode, v);
  }

  // Language
  static Locale? getLocale() {
    final value = _box.read<String>(_keyLanguage) ?? 'system';
    switch (value) {
      case 'en_US':
        return const Locale('en', 'US');
      case 'id_ID':
        return const Locale('id', 'ID');
      default:
        return null; // system
    }
  }

  static Future<void> setLanguage(String code) async {
    await _box.write(_keyLanguage, code);
  }
}

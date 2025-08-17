import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_coworkers/config/preferences.dart';

class SettingsController extends GetxController {
  void clear() {
    Get.delete<SettingsController>(force: true);
  }

  final _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;
  set themeMode(ThemeMode m) => _themeMode.value = m;

  // 'system', 'en_US', 'id_ID'
  final _languageCode = 'system'.obs;
  String get languageCode => _languageCode.value;
  set languageCode(String code) => _languageCode.value = code;

  @override
  void onInit() {
    super.onInit();
    // Load saved preferences
    final savedTheme = Preferences.getThemeMode();
    _themeMode.value = savedTheme;

    final savedLocale = Preferences.getLocale();
    if (savedLocale == null) {
      _languageCode.value = 'system';
    } else if (savedLocale.languageCode == 'id') {
      _languageCode.value = 'id_ID';
    } else {
      _languageCode.value = 'en_US';
    }
  }

  void applyTheme(ThemeMode mode) {
    themeMode = mode;
    Preferences.setThemeMode(mode);
    Get.changeThemeMode(mode);
  }

  void applyLanguage(String code) {
    languageCode = code;
    Preferences.setLanguage(code);
    if (code == 'system') {
      final loc = Get.deviceLocale ?? const Locale('en', 'US');
      Get.updateLocale(loc);
    } else if (code == 'id_ID') {
      Get.updateLocale(const Locale('id', 'ID'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}

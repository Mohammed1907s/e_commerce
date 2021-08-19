import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'hello': 'Hello World',
      'title': 'title',
    },
    'ar': {
      'hello': 'مرحباً',
      'title': 'العنوان',
    }
  };

  static void changeLang() {
    String newLanguageCode = SharedPreferencesController().languageCode == 'en' ? 'ar' : 'en';
    Get.updateLocale(Locale(newLanguageCode));
    SharedPreferencesController().setLanguage(newLanguageCode);
  }
}
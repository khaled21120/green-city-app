import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/services/prefs_service.dart';
import '../../../../../core/utils/constants.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageEnglish());

  Future<void> changeLanguage(Locale locale) async {
    if (locale.languageCode == 'ar') {
      emit(const LanguageArabic());
    } else {
      emit(const LanguageEnglish());
    }

    // Save language preference
    await PrefsService.setString(Constants.kLanguage, locale.languageCode);
  }

  void loadSavedLanguage() {
    String? savedLang = PrefsService.getString(Constants.kLanguage) ?? 'en';
    if (savedLang == 'ar') {
      emit(const LanguageArabic());
    } else {
      emit(const LanguageEnglish());
    }
  }
}

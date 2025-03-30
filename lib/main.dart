import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'core/services/get_it_service.dart';
import 'core/services/prefs_service.dart';
import 'core/utils/app_routers.dart';
import 'featuers/home/presentation/Cubits/Language Cubit/language_state.dart';
import 'featuers/home/presentation/Cubits/Theme Cubit/theme_cubit.dart';
import 'generated/l10n.dart';
import 'featuers/home/presentation/Cubits/Language Cubit/language_cubit.dart'; // Import LanguageCubit

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await PrefsService.init();

  final themeCubit = ThemeCubit();
  final languageCubit = LanguageCubit();

  themeCubit.loadTheme();
  languageCubit.loadSavedLanguage(); 

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => themeCubit),
        BlocProvider(create: (context) => languageCubit),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, langState) {
            return MaterialApp.router(
              locale: langState.locale, // Use language cubit's locale
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              title: 'Green City',
              theme: lightThemeData,
              darkTheme: darkThemeData,
              themeMode: themeState.themeMode,
              routerConfig: AppRouters.router,
            );
          },
        );
      },
    );
  }
}

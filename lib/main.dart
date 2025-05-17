import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:green_city/featuers/user/profile/cubit/profile_cubit.dart';

import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'core/services/get_it_service.dart';
import 'core/services/prefs_service.dart';
import 'core/utils/app_routers.dart';
import 'featuers/user/home/cubits/Language Cubit/language_state.dart';
import 'featuers/user/home/cubits/Theme Cubit/theme_cubit.dart';
import 'generated/l10n.dart';
import 'featuers/user/home/cubits/Language Cubit/language_cubit.dart'; // Import LanguageCubit

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupServiceLocator();
  await PrefsService.init();
  // final languageCubit = LanguageCubit();
  // final themeCubit = ThemeCubit();

  getIt.get<ThemeCubit>().loadTheme();
  getIt.get<LanguageCubit>().loadSavedLanguage();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<ThemeCubit>()),
        BlocProvider(create: (context) => getIt.get<LanguageCubit>()),
        BlocProvider(create: (context) => getIt.get<ProfileCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, langState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: langState.locale,
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

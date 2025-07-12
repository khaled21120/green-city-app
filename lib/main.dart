import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:app_links/app_links.dart'; 
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/user/presentation/cubits/profile/profile_cubit.dart';

import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'core/services/get_it_service.dart';
import 'core/services/prefs_service.dart';
import 'core/utils/app_routers.dart';
import 'featuers/auth/presentation/cubits/log_In/log_in_cubit.dart';
import 'featuers/user/presentation/cubits/language/language_state.dart';
import 'featuers/user/presentation/cubits/theme/theme_cubit.dart';
import 'generated/l10n.dart';
import 'featuers/user/presentation/cubits/language/language_cubit.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupServiceLocator();
  await PrefsService.init();

  final appLinks = AppLinks(); 

  final languageCubit = LanguageCubit();
  final themeCubit = ThemeCubit();
  languageCubit.loadSavedLanguage();
  await themeCubit.loadTheme();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit),
        BlocProvider(create: (_) => languageCubit),
        BlocProvider(create: (_) => getIt.get<ProfileCubit>()),
        BlocProvider(create: (_) => getIt.get<LogInCubit>()),
      ],
      child: MyApp(appLinks: appLinks), 
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppLinks appLinks;

  const MyApp({super.key, required this.appLinks});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    Future.delayed(
      const Duration(seconds: 2),
      () => FlutterNativeSplash.remove(),
    );
  }

  Future<void> _initDeepLinks() async {
    try {
      // Handle initial link if app was closed
      final initialUri = await widget.appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }

      // Listen for incoming links
      widget.appLinks.uriLinkStream.listen(_handleDeepLink);
    } catch (e) {
      debugPrint('Deep link error: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('DEEP LINK RECEIVED: $uri');

    if (uri.scheme == 'greencity') {
      final token = uri.queryParameters['token'];
      final email = uri.queryParameters['email'];

      if (token != null && email != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final ctx = navigatorKey.currentContext;
          if (ctx != null) {
            debugPrint('Navigating to reset screen...');
            ctx.goNamed(
              'resetPassword',
              extra: {'token': token, 'email': email},
            );
          } else {
            debugPrint('❌ navigatorKey.currentContext is null');
          }
        });
      }
    }
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

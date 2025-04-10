import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/auth/presentation/cubits/LogIn/log_in_cubit.dart';
import 'package:green_city/featuers/auth/presentation/cubits/SignUp/sign_up_cubit.dart';
import 'package:green_city/featuers/auth/presentation/login_page.dart';
import 'package:green_city/featuers/home/presentation/views/Notifications/notifications_view.dart';
import 'package:green_city/featuers/home/presentation/views/settings/settings_page.dart';
import 'package:green_city/featuers/splash/presentation/splash_page.dart';

import '../../featuers/auth/data/models/user_model.dart';
import '../../featuers/auth/presentation/cubits/Auth/auth_cubit.dart';
import '../../featuers/auth/presentation/intro_page.dart';
import '../../featuers/auth/presentation/signup_page.dart';
import '../../featuers/home/data/models/activities_model.dart';
import '../../featuers/home/presentation/Cubits/Announs Cubit/announs_cubit.dart';
import '../../featuers/home/presentation/Cubits/Polls Cubit/polls_cubit.dart';
import '../../featuers/home/presentation/Cubits/Notifications Cubit/notifications_cubit.dart';
import '../../featuers/home/presentation/views/About Us/about_us.dart';
import '../../featuers/home/presentation/views/Announcements/announcements.dart';
import '../../featuers/home/presentation/views/Chat/chat_page.dart';
import '../../featuers/home/presentation/views/FAQs/faqs_page.dart';
import '../../featuers/home/presentation/home_page.dart';
import '../../featuers/home/presentation/views/Polls/polls_view.dart';
import '../../featuers/home/presentation/views/chellanges/widgets/details.dart';
import '../services/get_it_service.dart';

abstract class AppRouters {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder:
            (_, _) => BlocProvider(
              create: (_) => AuthCubit(),
              child: const SplashPage(),
            ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<LogInCubit>(),
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder:
            (_, state) => BlocProvider(
              create: (_) => getIt.get<SignUpCubit>(),
              child: const SignUpPage(),
            ),
      ),
      GoRoute(
        path: '/intro',
        name: 'intro',
        builder: (_, _) => const IntroPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder:
            (_, _) => BlocProvider(
              create: (_) => AuthCubit(),
              child: const HomePage(),
            ),
      ),
      GoRoute(path: '/FAQs', name: 'FAQs', builder: (_, _) => const FAQsPage()),
      GoRoute(
        path: '/activityDetails',
        name: 'activityDetails',
        builder: (_, state) {
          final ActivitiesModel activitiesModel =
              state.extra as ActivitiesModel;
          return DetailsPage(activitiesModel: activitiesModel);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_, _) => const SettingsPage(),
      ),
      GoRoute(
        path: '/aboutUs',
        name: 'aboutUs',
        builder: (_, _) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/assistantPage',
        name: 'assistantPage',
        builder: (_, state) {
          final userModel = state.extra as UserModel;
          return ChatPage(userModel: userModel);
        },
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder:
            (_, __) => BlocProvider(
              create:
                  (context) =>
                      getIt<NotificationsCubit>()..loadAllNotifications(),
              child: const NotificationsView(),
            ),
      ),
      GoRoute(
        path: '/announcements',
        name: 'announcements',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<AnnounsCubit>(),
              child: const AnnouncementsPage(),
            ),
      ),
      GoRoute(
        path: '/polls',
        name: 'polls',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<PollsCubit>()..getPolls(),
              child: const PollsView(),
            ),
      ),
    ],
  );
}

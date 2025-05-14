import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/user/home/presentation/views/Contact%20Us/contact_us_view.dart';

import '../../featuers/driver/presentation/profile/driver_profile.dart';
import '../services/back_auth_service.dart';
import '../../featuers/admin/home/admin_home_page.dart';
import '../../featuers/admin/home/cubits/cubit/reports_cubit.dart';
import '../../featuers/admin/home/widgets/waste_details.dart';
import '../../featuers/admin/profile/admin_profile.dart';
import '../../featuers/auth/cubits/Auth/auth_cubit.dart';
import '../../featuers/auth/cubits/LogIn/log_in_cubit.dart';
import '../../featuers/auth/cubits/SignUp/sign_up_cubit.dart';
import '../../featuers/auth/data/models/user_model.dart';
import '../../featuers/auth/presentation/intro_page.dart';
import '../../featuers/auth/presentation/login_page.dart';
import '../../featuers/auth/presentation/signup_page.dart';
import '../../featuers/driver/presentation/home/driver_home_view.dart';
import '../../featuers/user/home/cubits/Announs Cubit/announs_cubit.dart';
import '../../featuers/user/home/cubits/Notifications Cubit/notifications_cubit.dart';
import '../../featuers/user/home/cubits/Polls Cubit/polls_cubit.dart';
import '../../featuers/user/home/data/models/activities_model.dart';
import '../../featuers/user/home/presentation/user_home_page.dart';
import '../../featuers/user/home/presentation/views/About Us/about_us.dart';
import '../../featuers/user/home/presentation/views/Announcements/announs_view.dart';
import '../../featuers/user/home/presentation/views/Announcements/my_announs_view.dart';
import '../../featuers/user/home/presentation/views/Chat/chat_page.dart';
import '../../featuers/user/home/presentation/views/FAQs/faqs_page.dart';
import '../../featuers/user/home/presentation/views/Notifications/notifications_view.dart';
import '../../featuers/user/home/presentation/views/Polls/polls_view.dart';
import '../../featuers/user/home/presentation/views/chellanges/widgets/details.dart';
import '../../featuers/user/profile/presentation/edit/edit_profile_view.dart';
import '../../featuers/user/profile/presentation/settings/settings_page.dart';
import '../services/get_it_service.dart';

abstract class AppRouters {
  static bool _isAuthRoute(String location) {
    return ['/login', '/signup', '/intro'].contains(location);
  }

  static final router = GoRouter(
    redirect: (_, state) async {
      final authService = getIt.get<ApiAuthService>();
      final isLoggedIn = await authService.isLoggedIn();
      final isAuthRoute = _isAuthRoute(state.matchedLocation);

      if (isLoggedIn && isAuthRoute) return '/home';
      if (!isLoggedIn && !isAuthRoute) return '/intro';
      return null;
    },
    routes: [
      // Intro Screen (Initial Route)
      GoRoute(path: '/', redirect: (_, _) => '/intro'),
      GoRoute(
        path: '/intro',
        name: 'intro',
        builder: (_, _) => const IntroPage(),
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
        path: '/home',
        name: 'home',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt.get<AuthCubit>(),
              child: const UserHomePage(),
            ),
      ),
      GoRoute(
        path: '/adminHome',
        name: 'adminHome',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt.get<AuthCubit>(),
              child: const AdminHomePage(),
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
        path: '/adminProfile',
        name: 'adminProfile',
        builder: (_, __) => const AdminProfileview(),
      ),
      GoRoute(
        path: '/driverProfile',
        name: 'driverProfile',
        builder: (_, __) => const DriverProfileView(),
      ),
      GoRoute(
        path: '/contactUs',
        name: 'contactUs',
        builder: (_, __) => const ContactUsView(),
      ),
      GoRoute(
        path: '/announcements',
        name: 'announcements',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<AnnounsCubit>(),
              child: const AnnounsView(),
            ),
      ),
      GoRoute(
        path: '/editProfile',
        name: 'editProfile',
        builder: (_, state) {
          final user = state.extra as UserModel;
          return EditProfileView(user: user);
        },
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
      GoRoute(
        path: '/myAnnouncements',
        name: 'myAnnouncements',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<AnnounsCubit>()..fetchAnnouncements(),
              child: const MyAnnounsView(),
            ),
      ),
      GoRoute(
        path: '/wasteDetails',
        name: 'wasteDetails',
        builder: (_, state) {
          final title = state.extra as String;
          return BlocProvider(
            create: (context) => getIt<ReportsCubit>(),
            child: WasteDetails(title: title),
          );
        },
      ),
      GoRoute(
        path: '/driverHome',
        name: 'driverHome',
        builder: (_, state) => const DriverHomeView(),
      ),
    ],
  );
}

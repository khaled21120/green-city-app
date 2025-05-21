import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/featuers/admin/presentation/cubits/admin_report/admin_reports_cubit.dart';
import 'package:green_city/featuers/driver/presentation/cubits/Driver%20Reports/driver_reports_cubit.dart';
import 'package:green_city/featuers/driver/presentation/cubits/Driver%20Tasks/driver_tasks_cubit.dart';
import 'package:green_city/featuers/driver/presentation/views/home/views/pending_tasks/pending_tasks_view.dart';
import 'package:green_city/featuers/driver/presentation/views/profile/views/edit/edit_driver_profile_view.dart';
import 'package:green_city/featuers/user/presentation/views/profile/user_profile_page.dart';

import '../../featuers/driver/presentation/views/home/views/confirm_task/confirm_task_view.dart';
import '../../featuers/driver/presentation/views/home/views/today_tasks/today_tasks_view.dart';
import '../../featuers/driver/presentation/views/profile/driver_profile.dart';
import '../../featuers/user/presentation/cubits/activities/activities_cubit.dart';
import '../../featuers/user/presentation/cubits/user_report/user_reports_cubit.dart';
import '../../featuers/user/presentation/views/home/views/contact_us/contact_us_view.dart';
import '../../featuers/user/presentation/views/home/views/chellanges/chellange_page.dart';
import '../services/back_auth_service.dart';
import '../../featuers/admin/presentation/views/home/admin_home_page.dart';
import '../../featuers/admin/presentation/views/home/widgets/waste_details.dart';
import '../../featuers/admin/presentation/views/profile/admin_profile.dart';
import '../../featuers/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../featuers/auth/presentation/cubits/log_In/log_in_cubit.dart';
import '../../featuers/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import '../../featuers/auth/data/models/user_model.dart';
import '../../featuers/auth/presentation/intro_page.dart';
import '../../featuers/auth/presentation/login_page.dart';
import '../../featuers/auth/presentation/signup_page.dart';
import '../../featuers/driver/presentation/views/home/driver_home_view.dart';
import '../../featuers/user/presentation/cubits/notify/notify_cubit.dart';
import '../../featuers/user/presentation/cubits/polls/polls_cubit.dart';
import '../../featuers/user/data/models/activities_model.dart';
import '../../featuers/user/presentation/views/home/user_home_page.dart';
import '../../featuers/user/presentation/views/home/views/about_us/about_us.dart';
import '../../featuers/user/presentation/views/home/views/reports/reports_view.dart';
import '../../featuers/user/presentation/views/home/views/reports/my_reports_view.dart';
import '../../featuers/user/presentation/views/home/views/chat/chat_page.dart';
import '../../featuers/user/presentation/views/home/views/faqs/faqs_page.dart';
import '../../featuers/user/presentation/views/home/views/notify/notifications_view.dart';
import '../../featuers/user/presentation/views/home/views/polls/polls_view.dart';
import '../../featuers/user/presentation/views/home/views/chellanges/widgets/details.dart';
import '../../featuers/user/presentation/views/profile/views/edit/edit_user_profile_view.dart';
import '../../featuers/user/presentation/views/profile/views/settings/settings_page.dart';
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

      if (isLoggedIn && isAuthRoute) {
        final role = Helper.getUser().role;
        if (role == 'Admin') return '/adminHome';
        if (role == 'TruckDriver') return '/driverHome';
        return '/home';
      }

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
          return BlocProvider(
            create: (context) => getIt.get<ActivitiesCubit>(),
            child: ActivitiesDetailsPage(activitiesModel: activitiesModel),
          );
        },
      ),
      GoRoute(
        path: '/activities',
        name: 'activities',
        builder:
            (_, state) => BlocProvider(
              create:
                  (context) => getIt.get<ActivitiesCubit>()..getActivities(),
              child: const ActivitiesView(),
            ),
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
        path: '/reports',
        name: 'reports',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<UserReportsCubit>(),
              child: const ReportsView(),
            ),
      ),
      GoRoute(
        path: '/editProfile',
        name: 'editProfile',
        builder: (_, state) {
          final user = state.extra as UserModel;
          return EditUserProfileView(user: user);
        },
      ),
      GoRoute(
        path: '/editDriverProfile',
        name: 'editDriverProfile',
        builder: (_, state) {
          final user = state.extra as UserModel;
          return EditDriverProfileView(user: user);
        },
      ),
      GoRoute(
        path: '/userProfile',
        name: 'userProfile',
        builder: (_, _) => const UserProfilePage(),
      ),
      GoRoute(
        path: '/todayTasks',
        name: 'todayTasks',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<DriverTasksCubit>()..getAllTasks(),
              child: const TodayTasksView(),
            ),
      ),
      GoRoute(
        path: '/pendingTasks',
        name: 'pendingTasks',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<DriverTasksCubit>()..getDriverTasks(),
              child: const PendingTasksView(),
            ),
      ),
      GoRoute(
        path: '/confirmTasks',
        name: 'confirmTasks',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<DriverReportsCubit>(),
              child: const ConfirmTaskView(),
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
      GoRoute(
        path: '/myReports',
        name: 'myReports',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt<UserReportsCubit>()..fetchReports(),
              child: const MyReportsView(),
            ),
      ),
      GoRoute(
        path: '/wasteDetails',
        name: 'wasteDetails',
        builder: (_, state) {
          final title = state.extra as String;
          return BlocProvider(
            create: (context) => getIt<AdminReportsCubit>(),
            child: WasteDetails(title: title),
          );
        },
      ),
      GoRoute(
        path: '/driverHome',
        name: 'driverHome',
        builder:
            (_, _) => BlocProvider(
              create: (context) => getIt.get<AuthCubit>(),
              child: const DriverHomeView(),
            ),
      ),
    ],
  );
}

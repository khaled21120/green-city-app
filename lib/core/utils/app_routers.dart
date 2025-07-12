import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/featuers/admin/presentation/cubits/admin_report/admin_reports_cubit.dart';
import 'package:green_city/featuers/admin/presentation/views/home/admin_home_page.dart';
import 'package:green_city/featuers/admin/presentation/views/home/widgets/waste_details.dart';
import 'package:green_city/featuers/admin/presentation/views/profile/admin_profile.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/auth/presentation/reset_password_screen.dart';
import 'package:green_city/featuers/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:green_city/featuers/auth/presentation/cubits/log_In/log_in_cubit.dart';
import 'package:green_city/featuers/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:green_city/featuers/auth/presentation/intro_page.dart';
import 'package:green_city/featuers/auth/presentation/login_page.dart';
import 'package:green_city/featuers/auth/presentation/signup_page.dart';
import 'package:green_city/featuers/driver/presentation/cubits/driver_tasks/driver_tasks_cubit.dart';
import 'package:green_city/featuers/driver/presentation/cubits/driver_reports/driver_reports_cubit.dart';
import 'package:green_city/featuers/driver/presentation/cubits/paid_tasks/paid_tasks_cubit.dart';
import 'package:green_city/featuers/driver/presentation/views/home/driver_home_view.dart';
import 'package:green_city/featuers/driver/presentation/views/home/views/accepted_paid_tasks/pending_paid_tasks_view.dart';
import 'package:green_city/featuers/driver/presentation/views/home/views/all_paid_tasks/paid_tasks_view.dart';
import 'package:green_city/featuers/driver/presentation/views/home/views/pending_tasks/pending_tasks_view.dart';
import 'package:green_city/featuers/driver/presentation/views/home/views/today_tasks/today_tasks_view.dart';
import 'package:green_city/featuers/driver/presentation/views/profile/driver_profile.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
import 'package:green_city/featuers/user/presentation/cubits/activities/activities_cubit.dart';
import 'package:green_city/featuers/user/presentation/cubits/contact_us/contact_us_cubit.dart';
import 'package:green_city/featuers/user/presentation/cubits/notify/notify_cubit.dart';
import 'package:green_city/featuers/user/presentation/cubits/polls/polls_cubit.dart';
import 'package:green_city/featuers/user/presentation/cubits/user_report/user_reports_cubit.dart';
import 'package:green_city/featuers/user/presentation/views/home/user_home_page.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/about_us/about_us.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/activities/chellange_page.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/activities/my_activities_view.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/activities/widgets/details.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/chat/chat_page.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/contact_us/contact_us_view.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/faqs/faqs_page.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/notify/notifications_view.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/polls/polls_view.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/polls/widgets/fullscreen_webview.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/reports/my_reports_view.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/reports/reports_view.dart';
import 'package:green_city/featuers/user/presentation/views/profile/user_profile_page.dart';
import 'package:green_city/featuers/user/presentation/views/profile/views/edit/edit_user_profile_view.dart';
import 'package:green_city/featuers/user/presentation/views/profile/views/settings/settings_page.dart';
import '../../featuers/user/presentation/views/home/views/subscription/my_subscription_page.dart';
import '../services/back_auth_service.dart';
import '../services/get_it_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouters {
  static bool _isAuthRoute(String location) {
    return ['/login', '/signup', '/intro'].contains(location);
  }

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    redirect: (_, state) async {
      final authService = getIt.get<ApiAuthService>();
      final isLoggedIn = await authService.isLoggedIn();
      final isAuthRoute = _isAuthRoute(state.matchedLocation);

      if (isLoggedIn && isAuthRoute) {
        final role = Helper.getUser().role;
        if (role == 'RecylingManagemnet') return '/adminHome';
        if (role == 'TruckDriver') return '/driverHome';
        return '/home';
      }

      if (!isLoggedIn && !isAuthRoute) return '/intro';
      return null;
    },
    routes: [
      // Auth Routes
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
            (_, _) => BlocProvider(
              create: (_) => getIt.get<SignUpCubit>(),
              child: const SignUpPage(),
            ),
      ),
      GoRoute(
        path: '/resetPassword',
        name: 'resetPassword',
        builder: (_, state) {
          final args = state.extra;

          if (args is! Map<String, dynamic>) {
            return const Scaffold(body: Center(child: Text('Invalid link')));
          }

          final token = args['token'] as String?;
          final email = args['email'] as String?;

          if (token == null || email == null) {
            return const Scaffold(
              body: Center(child: Text('Missing token or email')),
            );
          }

          return BlocProvider(
            create: (_) => getIt.get<LogInCubit>(),
            child: ResetPasswordScreen(token: token, email: email),
          );
        },
      ),

      // Main Home Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<AuthCubit>(),
              child: const UserHomePage(),
            ),
      ),
      GoRoute(
        path: '/adminHome',
        name: 'adminHome',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<AuthCubit>(),
              child: const AdminHomePage(),
            ),
      ),
      GoRoute(
        path: '/driverHome',
        name: 'driverHome',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<AuthCubit>(),
              child: const DriverHomeView(),
            ),
      ),

      // Profile Routes
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
        path: '/userProfile',
        name: 'userProfile',
        builder: (_, _) => const UserProfilePage(),
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
        path: '/settings',
        name: 'settings',
        builder: (_, _) => const SettingsPage(),
      ),

      // Activity Routes
      GoRoute(
        path: '/activities',
        name: 'activities',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<ActivitiesCubit>()..getAllActivities(),
              child: const ActivitiesView(),
            ),
      ),
      GoRoute(
        path: '/myActivities',
        name: 'myActivities',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt.get<ActivitiesCubit>()..getMyActivities(),
              child: const MyActivitiesView(),
            ),
      ),
      GoRoute(
        path: '/activityDetails',
        name: 'activityDetails',
        builder: (_, state) {
          final activitiesModel = state.extra as ActivitiesModel;
          return BlocProvider(
            create: (_) => getIt.get<ActivitiesCubit>(),
            child: ActivitiesDetailsPage(activitiesModel: activitiesModel),
          );
        },
      ),
      GoRoute(
        path: '/mySubscription',
        name: 'mySubscription',
        builder:
            (_, _) => BlocProvider(
              create:
                  (_) => getIt.get<UserReportsCubit>()..fetchSubscribStatus(),
              child: const MySubscriptionPage(),
            ),
      ),

      // Task Routes (Driver)
      GoRoute(
        path: '/todayTasks',
        name: 'todayTasks',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt<DriverTasksCubit>()..getAllTasks(),
              child: const TodayTasksView(),
            ),
      ),
      GoRoute(
        path: '/paidTasks',
        name: 'paidTasks',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt<PaidTasksCubit>()..getAllPaidTasks(),
              child: const PaidTasksView(),
            ),
      ),
      GoRoute(
        path: '/pendingPaidTasks',
        name: 'pendingPaidTasks',
        builder:
            (_, _) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (_) => getIt<PaidTasksCubit>()..getAcceptedPaidTasks(),
                ),
                BlocProvider(create: (_) => getIt<DriverReportsCubit>()),
              ],
              child: const PendingPaidTasksView(),
            ),
      ),
      GoRoute(
        path: '/pendingTasks',
        name: 'pendingTasks',
        builder:
            (_, _) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => getIt<DriverTasksCubit>()..getDriverTasks(),
                ),
                BlocProvider(create: (_) => getIt<DriverReportsCubit>()),
              ],
              child: const PendingTasksView(),
            ),
      ),

      // Report Routes
      GoRoute(
        path: '/reports',
        name: 'reports',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt<UserReportsCubit>()..fetchRegions(),
              child: const ReportsView(),
            ),
      ),
      GoRoute(
        path: '/myReports',
        name: 'myReports',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt<UserReportsCubit>()..fetchReports(),
              child: const MyReportsView(),
            ),
      ),
      GoRoute(
        path: '/wasteDetails',
        name: 'wasteDetails',
        builder: (_, state) {
          final title = state.extra as String;
          return BlocProvider(
            create: (_) => getIt<AdminReportsCubit>()..fetchWarehouses(),
            child: WasteDetails(title: title),
          );
        },
      ),

      // Other Feature Routes
      GoRoute(
        path: '/polls',
        name: 'polls',
        builder:
            (_, _) => BlocProvider(
              create: (_) => getIt<PollsCubit>()..getPolls(),
              child: const PollsView(),
            ),
      ),
      GoRoute(
        path: '/webView',
        name: 'webView',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          final title = extra['title'] as String;
          final url = extra['url'] as String;
          return FullScreenWebView(url: url, title: title);
        },
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder:
            (_, __) => BlocProvider(
              create:
                  (_) => getIt<NotificationsCubit>()..loadAllNotifications(),
              child: const NotificationsView(),
            ),
      ),
      GoRoute(
        path: '/contactUs',
        name: 'contactUs',
        builder:
            (_, __) => BlocProvider(
              create: (_) => getIt<ContactUsCubit>(),
              child: const ContactUsView(),
            ),
      ),
      GoRoute(
        path: '/assistantPage',
        name: 'assistantPage',
        builder: (_, state) {
          final userModel = state.extra as UserModel;
          return ChatPage(userModel: userModel);
        },
      ),
      GoRoute(path: '/FAQs', name: 'FAQs', builder: (_, _) => const FAQsPage()),
      GoRoute(
        path: '/aboutUs',
        name: 'aboutUs',
        builder: (_, _) => const AboutUsPage(),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/admin/home/admin_home_page.dart';
import 'package:green_city/featuers/admin/home/cubits/cubit/reports_cubit.dart';
import '../../featuers/admin/home/widgets/waste_details.dart';
import '../../featuers/admin/profile/admin_profile.dart';
import '../../featuers/auth/cubits/LogIn/log_in_cubit.dart';
import '../../featuers/auth/cubits/SignUp/sign_up_cubit.dart';
import '../../featuers/auth/presentation/login_page.dart';
import '../../featuers/user/home/presentation/views/Notifications/notifications_view.dart';
import '../../featuers/user/profile/presentation/settings/settings_page.dart';
import '../../featuers/splash/presentation/splash_page.dart';
import '../../featuers/auth/data/models/user_model.dart';
import '../../featuers/auth/cubits/Auth/auth_cubit.dart';
import '../../featuers/auth/presentation/intro_page.dart';
import '../../featuers/auth/presentation/signup_page.dart';
import '../../featuers/user/home/data/models/activities_model.dart';
import '../../featuers/user/home/cubits/Announs Cubit/announs_cubit.dart';
import '../../featuers/user/home/cubits/Polls Cubit/polls_cubit.dart';
import '../../featuers/user/home/cubits/Notifications Cubit/notifications_cubit.dart';
import '../../featuers/user/home/presentation/views/About Us/about_us.dart';
import '../../featuers/user/home/presentation/views/Announcements/announs_view.dart';
import '../../featuers/user/home/presentation/views/Announcements/my_announs_view.dart';
import '../../featuers/user/home/presentation/views/Chat/chat_page.dart';
import '../../featuers/user/home/presentation/views/FAQs/faqs_page.dart';
import '../../featuers/user/home/presentation/user_home_page.dart';
import '../../featuers/user/home/presentation/views/Polls/polls_view.dart';
import '../../featuers/user/home/presentation/views/chellanges/widgets/details.dart';
import '../../featuers/user/profile/presentation/edit/edit_profile_view.dart';
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
              create: (context) => getIt.get<AuthCubit>(),
              child: const UserHomePage(),
            ),
      ),
      GoRoute(
        path: '/homes',
        name: 'homes',
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
        builder: (_, __) => const AdminProfilePage(),
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
          final data = state.extra as Map<String, dynamic>;
          final user = data['user'] as UserModel;
          final nameController =
              data['nameController'] as TextEditingController;
          final phoneController =
              data['phoneController'] as TextEditingController;
          final addressController =
              data['addressController'] as TextEditingController;
          return EditProfileView(
            user: user,
            phoneController: phoneController,
            addressController: addressController,
            nameController: nameController,
          );
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
    ],
  );
}

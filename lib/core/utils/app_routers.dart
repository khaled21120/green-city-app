import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/auth/presentation/login_page.dart';
import 'package:green_city/featuers/home/presentation/views/settings/settings_page.dart';
import 'package:green_city/featuers/splash/presentation/splash_page.dart';

import '../../featuers/auth/presentation/intro_page.dart';
import '../../featuers/auth/presentation/signup_page.dart';
import '../../featuers/home/data/models/activities_model.dart';
import '../../featuers/home/presentation/views/About Us/about_us.dart';
import '../../featuers/home/presentation/views/Announcements/announcements.dart';
import '../../featuers/home/presentation/views/FAQs/faqs_page.dart';
import '../../featuers/home/presentation/home_page.dart';
import '../../featuers/home/presentation/views/chellanges/widgets/details.dart';

abstract class AppRouters {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/s', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/intro', builder: (context, state) => const IntroPage()),
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/FAQs', builder: (context, state) => const FAQsPage()),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final ActivitiesModel activitiesModel =
              state.extra as ActivitiesModel;

          return DetailsPage(activitiesModel: activitiesModel);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/aboutUs',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/announcements',
        builder: (context, state) => const AnnouncementsPage(),
      ),
    ],
  );
}

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/services/back_storage_service.dart';
import 'package:green_city/core/utils/app_routers.dart';
import 'package:green_city/featuers/admin/home/cubits/cubit/admin_reports_cubit.dart';
import 'package:green_city/featuers/admin/home/data/repo/admin_repo.dart';
import 'package:green_city/featuers/auth/cubits/Auth/auth_cubit.dart';
import 'package:green_city/featuers/auth/cubits/LogIn/log_in_cubit.dart';
import 'package:green_city/featuers/auth/cubits/SignUp/sign_up_cubit.dart';
import 'package:green_city/featuers/driver/cubits/Driver%20Reports/driver_reports_cubit.dart';
import 'package:green_city/featuers/driver/cubits/Driver%20Tasks/driver_tasks_cubit.dart';
import 'package:green_city/featuers/user/home/cubits/Activities%20Cubit/activities_cubit.dart';
import 'package:green_city/featuers/user/home/cubits/Language%20Cubit/language_cubit.dart';
import 'package:green_city/featuers/user/profile/cubit/profile_cubit.dart';
import '../../featuers/admin/home/data/repo/admin_repo_impl.dart';
import '../../featuers/driver/data/repo/driver_repo.dart';
import '../../featuers/driver/data/repo/driver_repo_impl.dart';
import '../../featuers/user/home/cubits/Polls Cubit/polls_cubit.dart';
import '../../featuers/user/home/cubits/Theme Cubit/theme_cubit.dart';
import '../../featuers/user/home/cubits/User Report Cubit/user_reports_cubit.dart';
import '../../featuers/user/home/data/repo/user_repo_impl.dart';
import '../../featuers/user/home/data/repo/user_repo.dart';
import '../../featuers/user/home/cubits/Notifications Cubit/notifications_cubit.dart';

import '../../featuers/auth/data/repo/auth_repo_impl.dart';
import '../../featuers/auth/data/repo/auth_repo.dart';
import 'back_auth_service.dart';
import 'data_base_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<GoRouter>(AppRouters.router);
  getIt.registerSingleton<DatabaseService>(ApiStorageService());
  getIt.registerSingleton<ApiAuthService>(ApiAuthService());
  getIt.registerSingleton<UserRepo>(UserRepoImpl(getIt.get<DatabaseService>()));
  getIt.registerSingleton<DriverRepo>(
    DriverRepoImpl(getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AdminRepo>(
    AdminRepoImpl(getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<ApiAuthService>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<ApiAuthService>()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt<AuthRepo>()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<AuthRepo>()));
  getIt.registerFactory<AdminReportsCubit>(
    () => AdminReportsCubit(getIt<AdminRepo>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<UserRepo>(), getIt<AuthRepo>()),
  );
  getIt.registerFactory<ActivitiesCubit>(
    () => ActivitiesCubit(getIt<UserRepo>()),
  );
  getIt.registerFactory<PollsCubit>(() => PollsCubit(getIt<UserRepo>()));
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<LanguageCubit>(() => LanguageCubit());
  getIt.registerFactory<DriverReportsCubit>(
    () => DriverReportsCubit(getIt<DriverRepo>()),
  );
  getIt.registerFactory<DriverTasksCubit>(
    () => DriverTasksCubit(getIt<DriverRepo>()),
  );
  getIt.registerFactory<UserReportsCubit>(
    () => UserReportsCubit(getIt<UserRepo>()),
  );
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(getIt<UserRepo>()),
  );
}

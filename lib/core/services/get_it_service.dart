import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/services/back_storage_service.dart';
import 'package:green_city/core/utils/app_routers.dart';
import 'package:green_city/featuers/admin/home/cubits/cubit/reports_cubit.dart';
import 'package:green_city/featuers/admin/home/data/repo/admin_home_repo.dart';
import 'package:green_city/featuers/auth/cubits/Auth/auth_cubit.dart';
import 'package:green_city/featuers/auth/cubits/LogIn/log_in_cubit.dart';
import 'package:green_city/featuers/auth/cubits/SignUp/sign_up_cubit.dart';
import 'package:green_city/featuers/user/home/cubits/Announs%20Cubit/announs_cubit.dart';
import 'package:green_city/featuers/user/profile/cubit/profile_cubit.dart';
import 'package:green_city/featuers/user/home/cubits/Polls%20Cubit/polls_cubit.dart';
import '../../featuers/admin/home/data/repo/admin_home_repo_impl.dart';
import '../../featuers/user/home/data/repo/user_home_repo_impl.dart';
import '../../featuers/user/home/data/repo/user_home_repo.dart';
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
  getIt.registerSingleton<UserHomeRepo>(
    UserHomeRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AdminHomeRepo>(
    AdminHomeRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()),
  );
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<ApiAuthService>()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt<AuthRepo>()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<AuthRepo>()));
  getIt.registerFactory<ReportsCubit>(
    () => ReportsCubit(getIt<AdminHomeRepo>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<UserHomeRepo>(), getIt<AuthRepo>()),
  );
  getIt.registerFactory<PollsCubit>(() => PollsCubit(getIt<UserHomeRepo>()));
  getIt.registerFactory<AnnounsCubit>(
    () => AnnounsCubit(getIt<UserHomeRepo>()),
  );
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(getIt<UserHomeRepo>()),
  );
}

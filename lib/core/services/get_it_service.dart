import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/admin/data/repo/admin_repo.dart';
import '../../featuers/admin/data/repo/admin_repo_impl.dart';
import '../../featuers/admin/presentation/cubits/admin_report/admin_reports_cubit.dart';
import '../../featuers/auth/data/repo/auth_repo.dart';
import '../../featuers/auth/data/repo/auth_repo_impl.dart';
import '../../featuers/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../featuers/auth/presentation/cubits/log_In/log_in_cubit.dart';
import '../../featuers/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import '../../featuers/driver/data/repo/driver_repo.dart';
import '../../featuers/driver/data/repo/driver_repo_impl.dart';
import '../../featuers/driver/presentation/cubits/Driver%20Reports/driver_reports_cubit.dart';
import '../../featuers/driver/presentation/cubits/Driver%20Tasks/driver_tasks_cubit.dart';
import '../../featuers/driver/presentation/cubits/cubit/paid_tasks_cubit.dart';
import '../../featuers/user/data/repo/user_repo.dart';
import '../../featuers/user/data/repo/user_repo_impl.dart';
import '../../featuers/user/presentation/cubits/activities/activities_cubit.dart';
import '../../featuers/user/presentation/cubits/contact_us/contact_us_cubit.dart';
import '../../featuers/user/presentation/cubits/language/language_cubit.dart';
import '../../featuers/user/presentation/cubits/notify/notify_cubit.dart';
import '../../featuers/user/presentation/cubits/polls/polls_cubit.dart';
import '../../featuers/user/presentation/cubits/profile/profile_cubit.dart';
import '../../featuers/user/presentation/cubits/theme/theme_cubit.dart';
import '../../featuers/user/presentation/cubits/user_report/user_reports_cubit.dart';
import '../network/dio_factory.dart';
import '../utils/app_routers.dart';
import 'back_auth_service.dart';
import 'back_storage_service.dart';
import 'data_base_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  _registerCoreServices();
  _registerRepos();
  _registerCubits();
}

void _registerCoreServices() {
  getIt.registerLazySingleton<Dio>(() => DioFactory.dio);
  getIt.registerLazySingleton<GoRouter>(() => AppRouters.router);
  getIt.registerLazySingleton<DatabaseService>(
    () => ApiStorageService(getIt()),
  );
  getIt.registerLazySingleton<ApiAuthService>(() => ApiAuthService(getIt()));
}

void _registerRepos() {
  getIt.registerLazySingleton<UserRepo>(() => UserRepoImpl(getIt()));
  getIt.registerLazySingleton<DriverRepo>(() => DriverRepoImpl(getIt()));
  getIt.registerLazySingleton<AdminRepo>(() => AdminRepoImpl(getIt()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
}

void _registerCubits() {
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<AdminReportsCubit>(() => AdminReportsCubit(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt(), getIt()));
  getIt.registerFactory<ActivitiesCubit>(() => ActivitiesCubit(getIt()));
  getIt.registerFactory<PollsCubit>(() => PollsCubit(getIt()));
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<LanguageCubit>(() => LanguageCubit());
  getIt.registerFactory<DriverReportsCubit>(() => DriverReportsCubit(getIt()));
  getIt.registerFactory<DriverTasksCubit>(() => DriverTasksCubit(getIt()));
  getIt.registerFactory<UserReportsCubit>(() => UserReportsCubit(getIt()));
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));
  getIt.registerFactory<ContactUsCubit>(() => ContactUsCubit(getIt()));
  getIt.registerFactory<PaidTasksCubit>(() => PaidTasksCubit(getIt()));
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:green_city/core/services/back_storage_service.dart';
import 'package:green_city/featuers/auth/presentation/cubits/Auth/auth_cubit.dart';
import 'package:green_city/featuers/auth/presentation/cubits/LogIn/log_in_cubit.dart';
import 'package:green_city/featuers/auth/presentation/cubits/SignUp/sign_up_cubit.dart';
import 'package:green_city/featuers/home/presentation/Cubits/Announs%20Cubit/announs_cubit.dart';
import 'package:green_city/featuers/profile/cubit/profile_cubit.dart';
import 'package:green_city/featuers/home/presentation/Cubits/Polls%20Cubit/polls_cubit.dart';
import '../../featuers/home/data/repo/home_repo_impl.dart';
import '../../featuers/home/data/repo/home_repo.dart';
import '../../featuers/home/presentation/Cubits/Notifications Cubit/notifications_cubit.dart';
import '../utils/endpoints.dart';

import '../../featuers/auth/data/repo/auth_repo_impl.dart';
import '../../featuers/auth/data/repo/auth_repo.dart';
import 'back_auth_service.dart';
import 'data_base_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );
  getIt.registerSingleton<DatabaseService>(
    ApiStorageService(dio: getIt.get<Dio>()),
  );
  getIt.registerSingleton<ApiAuthService>(
    ApiAuthService(dio: getIt.get<Dio>()),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()),
  );
  getIt.registerFactory<AuthCubit>(() => AuthCubit());
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt<AuthRepo>()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<AuthRepo>()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<HomeRepo>()));
  getIt.registerFactory<PollsCubit>(() => PollsCubit(getIt<HomeRepo>()));
  getIt.registerFactory<AnnounsCubit>(() => AnnounsCubit(getIt<HomeRepo>()));
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(getIt<HomeRepo>()),
  );
}

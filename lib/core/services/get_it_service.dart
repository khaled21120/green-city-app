import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:green_city/core/services/back_storage_service.dart';
import '../../featuers/home/data/repo/home_repo_impl.dart';
import '../../featuers/home/domain/repo/home_repo.dart';
import '../utils/endpoints.dart';

import '../../featuers/auth/data/repo/auth_repo_impl.dart';
import '../../featuers/auth/domain/repo/auth_repo.dart';
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
    BackendStorageService(dio: getIt.get<Dio>()),
  );
  getIt.registerSingleton<BackendAuthService>(
    BackendAuthService(dio: getIt.get<Dio>()),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(backendAuthService: getIt.get<BackendAuthService>()),
  );
}

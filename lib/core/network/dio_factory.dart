import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/endpoints.dart';

import '../services/get_it_service.dart';
import '../services/prefs_service.dart';
import '../utils/constants.dart';

class DioFactory {
  DioFactory._();
  static Dio? dioInstance;
  static final storage = const FlutterSecureStorage();

  static Dio get dio => dioInstance ??= _createDio();

  static Dio _createDio() {
    const timeOut = Duration(seconds: 30);
    return Dio()
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = timeOut
      ..options.receiveTimeout = timeOut
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await storage.read(key: Constants.kToken);
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401 ||
                error.response?.statusCode == 403) {
              await _forceLogout();
            }
            return handler.next(error);
          },
        ),
      );
  }

  static Future<void> _forceLogout() async {
    await Future.wait([
      storage.delete(key: Constants.kToken),
      PrefsService.clear(),
    ]);
    getIt<GoRouter>().go('/intro');
  }
}

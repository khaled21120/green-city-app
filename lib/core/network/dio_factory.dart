import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    final dio =
        Dio()
          ..options.baseUrl = Endpoints.baseUrl
          ..options.connectTimeout = timeOut
          ..options.receiveTimeout = timeOut
          ..options.followRedirects = true
          ..options.maxRedirects = 5
          ..interceptors.addAll([
            _createAuthInterceptor(),
            _createLoggingInterceptor(),
            _createErrorInterceptor(),
          ]);

    return dio;
  }

  static InterceptorsWrapper _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final token = await storage.read(key: Constants.kToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        } catch (e) {
          log('Auth interceptor error: $e');
          return handler.next(options);
        }
      },
    );
  }

  static InterceptorsWrapper _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        log('Request: ${options.method} ${options.uri}');
        log('Headers: ${options.headers}');
        if (options.data != null) {
          log('Body: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('Response: ${response.statusCode} ${response.requestOptions.uri}');
        log('Response data: ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) {
        log('Error: ${error.type}');
        log('Error message: ${error.message}');
        if (error.response != null) {
          log('Error response: ${error.response?.statusCode}');
          log('Error data: ${error.response?.data}');
        }
        return handler.next(error);
      },
    );
  }

  static InterceptorsWrapper _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        // Handle redirects
        if (error.response?.statusCode == 307 ||
            error.response?.statusCode == 301 ||
            error.response?.statusCode == 302) {
          log('Redirecting...');
          final newUrl = error.response?.headers['location']?.first;
          if (newUrl != null) {
            log('Redirecting to: $newUrl');
            try {
              final response = await dio.request(
                newUrl,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
              );
              return handler.resolve(response);
            } catch (e) {
              return handler.next(error);
            }
          }
        }

        // Handle unauthorized errors
        if (error.response?.statusCode == 401 ||
            error.response?.statusCode == 403) {
          await _forceLogout();
        }

        return handler.next(error);
      },
    );
  }

  static Future<void> _forceLogout() async {
    try {
      await Future.wait([
        storage.delete(key: Constants.kToken),
        PrefsService.clear(),
      ]);
      getIt<GoRouter>().go('/intro');
    } catch (e) {
      log('Force logout error: $e');
    }
  }
}

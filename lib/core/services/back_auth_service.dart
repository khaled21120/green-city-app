import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/services/get_it_service.dart';
import 'package:green_city/core/utils/constants.dart';

import '../errors/error.dart';
import 'prefs_service.dart';

class ApiAuthService {
  final Dio dio;
  final FlutterSecureStorage storage;

  ApiAuthService(this.dio) : storage = const FlutterSecureStorage();

  Future<void> _forceLogout() async {
    await Future.wait([
      storage.delete(key: Constants.kToken),
      PrefsService.clear(),
    ]);
  }

  Future<void> logOut() async {
    await _forceLogout();
    _redirectToSignIn();
  }

  void _redirectToSignIn() {
    getIt<GoRouter>().go('/intro');
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: Constants.kToken);
    final isValid = token != null;
    // && JwtDecoder.isExpired(token);
    return isValid;
  }

  Future<void> logIn({
    required String endPoint,
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        endPoint,
        data: {'emailAddress': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (res.statusCode == 200) {
        final userData = res.data as Map<String, dynamic>;
        await storage.write(
          key: Constants.kToken,
          value: userData[Constants.kToken],
        );
      } else {
        throw Exception('Login failed with status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  Future<void> signUp({
    required Map<String, dynamic> user,
    required String endPoint,
  }) async {
    try {
      FormData formData = FormData.fromMap(user);
      final res = await dio.post(
        endPoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final userData = res.data as Map<String, dynamic>;
        await storage.write(
          key: Constants.kToken,
          value: userData[Constants.kToken],
        );
      } else {
        throw Exception('Signup failed with status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  Future<Map<String, dynamic>> fetchUserData({required String endPoint}) async {
    try {
      final res = await dio.get(endPoint);

      if (res.statusCode == 200) {
        return res.data as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  Future<void> deleteUser({required String endPoint}) async {
    try {
      await dio.delete(endPoint);
      _redirectToSignIn();
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }
}

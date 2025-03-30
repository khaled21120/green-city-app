import 'package:dio/dio.dart';

import '../../featuers/auth/data/models/user_model.dart';
import '../errors/error.dart';
import 'prefs_service.dart';

class BackendAuthService {
  BackendAuthService({required this.dio});
  final Dio dio;

  Future<void> logIn({
    required String endPoint,
    required String email,
    required String password,
    String? token,
  }) async {
    try {
      final res = await dio.post(
        endPoint,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            if (token != null)
              'Authorization': 'Bearer $token', // Only if provided
          },
        ),
      );
      if (res.statusCode == 200) {
        final userData = res.data as Map<String, dynamic>;
        if (userData['token'] != null) {
          await PrefsService.setToken(userData['token']);
        }
      } else {
        throw Exception('Login failed with status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(
        dioError,
      ); // Use Failure class for clear errors
    }
  }

  Future<void> signUp({
    required UserModel user,
    required String endPoint,
    String? token,
  }) async {
    try {
      final res = await dio.post(
        endPoint,
        data: user.toJson(),
        options: Options(
          headers: {
            if (token != null)
              'Authorization': 'Bearer $token', // Only if provided
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final userData = res.data as Map<String, dynamic>;
        if (userData['token'] != null) {
          await PrefsService.setToken(userData['token']);
        }
      } else {
        throw Exception('Signup failed with status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(
        dioError,
      ); // Use Failure class for clear errors
    }
  }

  Future<Map<String, dynamic>> fetchUserData({required String endPoint}) async {
    try {
      final token = PrefsService.getToken();
      final res = await dio.get(
        endPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return res.data as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(
        dioError,
      ); // Use Failure class for clear errors
    }
  }

  Future<void> deleteUser({required String endPoint}) async {
    try {
      final token = PrefsService.getToken();
      await dio.delete(
        endPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  Future<void> logOut() async => await PrefsService.clear();
}

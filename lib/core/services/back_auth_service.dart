import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:green_city/core/utils/constants.dart';

import '../errors/error.dart';
import 'prefs_service.dart';

class ApiAuthService {
  ApiAuthService({required this.dio});
  final Dio dio;

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
        log(userData.toString());
        await PrefsService.setToken(userData[Constants.kToken]);
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
        await PrefsService.setToken(userData[Constants.kToken]);
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

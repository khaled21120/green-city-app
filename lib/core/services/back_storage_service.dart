import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/services/data_base_service.dart';
import 'package:green_city/core/services/get_it_service.dart';
import 'package:green_city/core/services/prefs_service.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/endpoints.dart';

import '../errors/error.dart';

class ApiStorageService extends DatabaseService {
  final Dio dio;
  final FlutterSecureStorage storage;

  ApiStorageService()
    : dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl)),
      storage = const FlutterSecureStorage() {
    dio.interceptors.add(
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
            _redirectToSignIn();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _forceLogout() async {
    await Future.wait([
      storage.delete(key: Constants.kToken),
      PrefsService.clear(),
    ]);
  }

  void _redirectToSignIn() {
    getIt<GoRouter>().go('/login');
  }

  @override
  Future<bool> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  }) async {
    try {
      final FormData formData = FormData.fromMap(data);
      final res = await dio.post(
        endPoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchMapData({
    required String endPoint,
    String? uId,
  }) async {
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

  @override
  Future<Map<String, dynamic>> fetchUserData({required String endPoint}) async {
    try {
      final res = await dio.get(endPoint);
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

  @override
  Future<void> deleteData({required String endPoint}) async {
    try {
      await dio.delete(endPoint);
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  @override
  Future<bool> updateData({
    required bool isImage,
    required String endPoint,
    required dynamic data,
  }) async {
    try {
      late FormData formData;
      if (isImage && data is File) {
        formData = FormData.fromMap({
          'profileImage': await MultipartFile.fromFile(
            data.path,
            filename: data.path.split('/').last,
          ),
        });
      } else {
        formData = FormData.fromMap(data as Map<String, dynamic>);
      }
      final res = await dio.put(
        endPoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } on ServerFailure {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<dynamic>> fetchListData({
    required String endPoint,
    String? uId,
  }) async {
    try {
      final res = await dio.get(endPoint);
      if (res.statusCode == 200) {
        return res.data as List<dynamic>;
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }
}

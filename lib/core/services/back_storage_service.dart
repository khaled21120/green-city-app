import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:green_city/core/services/data_base_service.dart';
import 'package:green_city/core/services/prefs_service.dart';

import '../errors/error.dart';

class ApiStorageService extends DatabaseService {
  final Dio dio;

  ApiStorageService({required this.dio});
  @override
  Future<bool> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  }) async {
    try {
      final token = PrefsService.getToken();
      final FormData formData = FormData.fromMap(data);
      final res = await dio.post(
        endPoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
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
  Future<bool> checkIfUserExist({required String endPoint, String? uId}) async {
    try {
      final res = await dio.get(endPoint);

      if (res.statusCode == 200) {
        return true; // ✅ User exists
      } else if (res.statusCode == 404) {
        return false; // ❌ User not found
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        return false; // ❌ User not found
      }
      throw ServerFailure.fromDioException(
        dioError,
      ); // Handle other errors properly
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

  @override
  Future<void> deleteData({required String endPoint}) async {
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

  @override
  Future<bool> updateData({
    required bool isImage,
    required String endPoint,
    required dynamic data,
  }) async {
    try {
      final token = PrefsService.getToken();
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
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
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
      final token = PrefsService.getToken();
      log(token!);
      final res = await dio.get(
        endPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
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

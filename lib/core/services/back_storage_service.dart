import 'package:dio/dio.dart';
import 'package:green_city/core/services/data_base_service.dart';

import '../errors/error.dart';

class BackendStorageService extends DatabaseService {
  final Dio dio;

  BackendStorageService({required this.dio});
  @override
  Future<void> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  }) async {
    try {
      // ignore: unused_local_variable
      final res = await dio.post(endPoint, data: data);
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
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
  Future<Map<String, dynamic>> fetchData({
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
  Future<void> deleteData({required String endPoint, String? uId}) async {
    try {
      // ignore: unused_local_variable
      final res = await dio.delete('$endPoint$uId');
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  @override
  Future<bool> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  }) async {
    try {
      final res = await dio.put('$endPoint$uId', data: data);
      if (res.statusCode == 200) {
        return true; // Success
      } else {
        return false;
      }
    } on DioException catch (dioError) {
      ServerFailure.fromDioException(dioError);
      return false;
    } catch (e) {
      return false;
    }
  }
}

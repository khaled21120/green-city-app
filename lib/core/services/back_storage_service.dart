import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:green_city/core/services/data_base_service.dart';

import '../errors/error.dart';

class ApiStorageService extends DatabaseService {
  final Dio dio;

  ApiStorageService(this.dio);

  @override
  Future<Either<Failure, bool>> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final formData = FormData.fromMap(data);
      final res = await dio.post(
        endPoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return right(true);
      } else {
        return left(ServerFailure('Unexpected status code: ${res.statusCode}'));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<Map<String, dynamic>> fetchMapData({required String endPoint}) async {
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
  Future<void> deleteData({required String endPoint}) async {
    try {
      await dio.delete(endPoint);
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  @override
  Future<bool> updateData({required String endPoint, required data}) async {
    try {
      late FormData formData;
      if (data is File) {
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
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  @override
  Future<List<dynamic>> fetchListData({required String endPoint}) async {
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

  @override
  Future<bool> postByID({required String endPoint, required String id}) async {
    try {
      final res = await dio.post('$endPoint/$id');
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }

  @override
  Future<bool> deleteByID({
    required String endPoint,
    required String id,
  }) async {
    try {
      final res = await dio.delete('$endPoint/$id');
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } on DioException catch (dioError) {
      throw ServerFailure.fromDioException(dioError);
    }
  }
}

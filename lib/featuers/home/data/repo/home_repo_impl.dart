import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants.dart';
import '../../../../core/errors/error.dart';
import '../../../../core/services/data_base_service.dart';
import '../../../../core/services/prefs_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.databaseService});
  final DatabaseService databaseService;

  @override
  Future<Either<Failures, UserModel>> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final isUpdated = await databaseService.updateData(
        endPoint: endPoint,
        data: data,
      );
      if (isUpdated) {
        final res = await databaseService.fetchData(endPoint: endPoint);
        final userData = UserModel.fromJson(res);
        await PrefsService.setString(
          Constants.kUserData,
          jsonEncode(userData.toJson()),
        );
        return Right(userData);
      } else {
        return Left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserModel>> fetchData({
    required String endPoint,
    String? uId,
  }) async {
    try {
      final user = await databaseService.fetchData(
        endPoint: endPoint,
        uId: uId,
      );
      return Right(UserModel.fromJson(user));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

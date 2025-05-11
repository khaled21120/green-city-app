import 'dart:convert';
import 'package:dartz/dartz.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/errors/error.dart';
import '../../../../../core/services/data_base_service.dart';
import '../../../../../core/services/prefs_service.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../user/home/data/models/announ_model.dart';
import 'admin_home_repo.dart';

class AdminHomeRepoImpl extends AdminHomeRepo {
  AdminHomeRepoImpl({required this.databaseService});
  final DatabaseService databaseService;

  @override
  Future<Either<Failures, UserModel>> updateUserData({
    required String endPoint,
    required dynamic data,
    required bool isImage,
  }) async {
    try {
      final isUpdated = await databaseService.updateData(
        endPoint: endPoint,
        data: data,
        isImage: isImage,
      );
      if (isUpdated) {
        final res = await databaseService.fetchUserData(endPoint: endPoint);
        final userData = UserModel.fromJson(res);
        await saveUserDataLocal(userData);
        return Right(userData);
      } else {
        return Left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserModel>> fetchUserData({
    required String endPoint,
    String? uId,
  }) async {
    try {
      final userData = await databaseService.fetchUserData(endPoint: endPoint);
      final user = UserModel.fromJson(userData);
      await saveUserDataLocal(user);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(
        ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}'),
      );
    }
  }

  @override
  Future saveUserDataLocal(UserModel user) async {
    final data = jsonEncode(user.toJson());
    await PrefsService.setString(Constants.kUserData, data);
  }

  @override
  Future<bool> sendreports({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await databaseService.sendData(
        endPoint: endPoint,
        data: data,
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}');
    }
  }

  @override
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      await databaseService.updateData(
        endPoint: endPoint,
        data: data,
        isImage: false,
      );
    } on ServerFailure catch (e) {
      throw ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}');
    }
  }

  @override
  Future<Either<Failures, List<AnnounsModel>>> fetchWehreHouses({
    required String endPoint,
  }) async {
    try {
      final anounnsList = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final anounns = anounnsList.map((e) => AnnounsModel.fromJson(e)).toList();
      return Right(anounns);
    } on ServerFailure catch (e) {
      return Left(
        ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}'),
      );
    }
  }
}

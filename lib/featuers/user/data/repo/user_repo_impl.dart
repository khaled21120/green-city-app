import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
import 'package:green_city/featuers/user/data/models/region_model.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/errors/error.dart';
import '../../../../core/services/data_base_service.dart';
import '../../../../core/services/prefs_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/polls_model.dart';
import 'user_repo.dart';

class UserRepoImpl extends UserRepo {
  UserRepoImpl(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<Failure, UserModel>> updateUserData({
    required String endPoint,
    required dynamic data,
    required bool isImage,
  }) async {
    try {
      final isUpdated = await databaseService.updateData(
        endPoint: endPoint,
        data: data,
      );
      if (isUpdated) {
        final res = await databaseService.fetchMapData(endPoint: endPoint);
        final userData = UserModel.fromJson(res);
        await saveUserDataLocal(userData);
        return Right(userData);
      } else {
        return Left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchUserData({
    required String endPoint,
  }) async {
    try {
      final userData = await databaseService.fetchMapData(endPoint: endPoint);
      final user = UserModel.fromJson(userData);
      await saveUserDataLocal(user);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future saveUserDataLocal(UserModel user) async {
    final data = jsonEncode(user.toJson());
    await PrefsService.setString(Constants.kUserData, data);
  }

  @override
  Future<Either<Failure, List<ActivitiesModel>>> fetchActivities({
    required String endPoint,
  }) async {
    try {
      final activitiesList = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final activities =
          activitiesList.map((e) => ActivitiesModel.fromJson(e)).toList();

      return Right(activities);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, List<PollsModel>>> fetchPolls({
    required String endPoint,
  }) async {
    try {
      final pollsList = await databaseService.fetchListData(endPoint: endPoint);
      final polls = pollsList.map((e) => PollsModel.fromJson(e)).toList();
      return Right(polls);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, void>> sendUserReports({
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
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> fetchNotifications({
    required String endPoint,
  }) async {
    try {
      final notification = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      return Right(notification);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<bool> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final isUpdated = await databaseService.updateData(
        endPoint: endPoint,
        data: data,
      );
      return isUpdated;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failure, List<UserReportsModel>>> fetchUserReports({
    required String endPoint,
  }) async {
    try {
      final anounnsList = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final anounns =
          anounnsList.map((e) => UserReportsModel.fromJson(e)).toList();
      return Right(anounns);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, List<RegionModel>>> fetchRegions({
    required String endPoint,
  }) async {
    try {
      final regionsList = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final regions = regionsList.map((e) => RegionModel.fromJson(e)).toList();
      return Right(regions);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, void>> editActivity({
    required String endPoint,
    required String id,
  }) async {
    try {
      await databaseService.postByID(endPoint: endPoint, id: id);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, void>> joinPoll({
    required String endPoint,
    required int id,
  }) async {
    try {
      await databaseService.postByID(endPoint: endPoint, id: '/$id/subscribe');
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String endPoint,
    required Map<String, dynamic> data,
  }) {
    try {
      final res = databaseService.sendData(endPoint: endPoint, data: data);
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<bool> deleteNotification({
    required String endPoint,
    required int id,
  }) async {
    try {
      final res = await databaseService.deleteByID(
        endPoint: endPoint,
        id: id.toString(),
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<bool> hideNotification({
    required String endPoint,
    required int id,
  }) async {
    try {
      final res = await databaseService.postByID(
        endPoint: endPoint,
        id: id.toString(),
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failure, UserReportsModel>> fetchSubscribStatus({
    required String endPoint,
  }) async {
    try {
      final sub = await databaseService.fetchMapData(endPoint: endPoint);
      final subStatus = UserReportsModel.fromJson(sub);
      return Right(subStatus);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, void>> cancelSubscription({
    required String endPoint,
  }) async {
    try {
      final res = await databaseService.sendData(endPoint: endPoint, data: {});
      return res;
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }
}

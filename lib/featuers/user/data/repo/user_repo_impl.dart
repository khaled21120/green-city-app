import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
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
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future saveUserDataLocal(UserModel user) async {
    final data = jsonEncode(user.toJson());
    await PrefsService.setString(Constants.kUserData, data);
  }

  @override
  Future<Either<Failures, List<ActivitiesModel>>> fetchActivities({
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
  Future<Either<Failures, List<PollsModel>>> fetchPolls({
    required String endPoint,
  }) async {
    try {
      final polls = await databaseService.fetchListData(endPoint: endPoint);
      final activities = polls.map((e) => PollsModel.fromJson(e)).toList();
      return Right(activities);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<bool> sendUserReports({
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
  Future<Either<Failures, List<dynamic>>> fetchUserNotifications({
    required String endPoint,
  }) async {
    try {
      // final notification = await databaseService.fetchListData(
      //   endPoint: endPoint,
      // );
      String jsonString = await rootBundle.loadString(Constants.db);
      // Decode the JSON string
      var jsonData = json.decode(jsonString);

      final notification = jsonData[endPoint] as List<dynamic>;

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
        isImage: false,
      );
      return isUpdated;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failures, List<UserReportsModel>>> fetchUserReports({
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
}

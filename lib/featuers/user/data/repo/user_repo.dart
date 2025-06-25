import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';
import 'package:green_city/featuers/user/data/models/polls_model.dart';

import '../../../../core/errors/error.dart';
import '../models/region_model.dart';

abstract class UserRepo {
  Future<Either<Failures, UserModel>> fetchUserData({required String endPoint});
  Future<Either<Failures, UserModel>> updateUserData({
    required String endPoint,
    required dynamic data,
    required bool isImage,
  });
  Future<bool> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<Either<Failures, bool>> joinPoll({
    required String endPoint,
    required int id,
  });

  Future<Either<Failures, bool>> editActivity({
    required String endPoint,
    required String id,
  });

  Future<Either<Failures, List<ActivitiesModel>>> fetchActivities({
    required String endPoint,
  });

  Future<Either<Failures, List<RegionModel>>> fetchRegions({
    required String endPoint,
  });
  Future<Either<Failures, List<PollsModel>>> fetchPolls({
    required String endPoint,
  });
  Future<Either<Failures, List<UserReportsModel>>> fetchUserReports({
    required String endPoint,
  });
  Future<bool> sendUserReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<bool> sendMessage({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future saveUserDataLocal(UserModel user);

  Future<Either<Failures, List<dynamic>>> fetchUserNotifications({
    required String endPoint,
  });
}

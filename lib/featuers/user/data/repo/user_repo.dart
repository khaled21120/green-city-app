import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';
import 'package:green_city/featuers/user/data/models/polls_model.dart';

import '../../../../core/errors/error.dart';
import '../models/region_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> fetchUserData({required String endPoint});
  Future<Either<Failure, UserModel>> updateUserData({
    required String endPoint,
    required dynamic data,
    required bool isImage,
  });
  Future<bool> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, void>> joinPoll({
    required String endPoint,
    required int id,
  });

  Future<Either<Failure, void>> editActivity({
    required String endPoint,
    required String id,
  });

  Future<Either<Failure, List<ActivitiesModel>>> fetchActivities({
    required String endPoint,
  });

  Future<Either<Failure, List<RegionModel>>> fetchRegions({
    required String endPoint,
  });
  Future<Either<Failure, List<PollsModel>>> fetchPolls({
    required String endPoint,
  });
  Future<Either<Failure, List<UserReportsModel>>> fetchUserReports({
    required String endPoint,
  });
  Future<Either<Failure, UserReportsModel>> fetchSubscribStatus({
    required String endPoint,
  });
  Future<Either<Failure, void>> sendUserReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, void>> sendMessage({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future saveUserDataLocal(UserModel user);

  Future<Either<Failure, List<dynamic>>> fetchNotifications({
    required String endPoint,
  });
  Future<bool> deleteNotification({required String endPoint, required int id});
  Future<bool> hideNotification({required String endPoint, required int id});
  Future<Either<Failure, void>> cancelSubscription({required String endPoint});
}

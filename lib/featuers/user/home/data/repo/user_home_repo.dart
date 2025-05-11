import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/featuers/user/home/data/models/activities_model.dart';
import 'package:green_city/featuers/user/home/data/models/announ_model.dart';
import 'package:green_city/featuers/user/home/data/models/polls_model.dart';
import 'package:green_city/featuers/user/home/data/models/public_notifiy_model.dart';

import '../../../../../core/errors/error.dart';
import '../models/user_notifiy_model.dart';

abstract class UserHomeRepo {
  Future<Either<Failures, UserModel>> fetchUserData({required String endPoint});
  Future<Either<Failures, UserModel>> updateUserData({
    required String endPoint,
    required dynamic data,
    required bool isImage,
  });
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failures, List<ActivitiesModel>>> fetchActivities({
    required String endPoint,
  });
  Future<Either<Failures, List<PollsModel>>> fetchPolls({
    required String endPoint,
  });
  Future<Either<Failures, List<AnnounsModel>>> fetchAnnouncements({
    required String endPoint,
  });
  Future<bool> sendAnnouncements({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future saveUserDataLocal(UserModel user);

  Future<Either<Failures, List<UserNotifiyModel>>> fetchUserNotifications({
    required String endPoint,
  });
  Future<Either<Failures, List<PublicNotifiyModel>>> fetchPublicNotifications({
    required String endPoint,
  });
}

import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import '../../../../../core/errors/error.dart';
import '../../../../user/home/data/models/announ_model.dart';

abstract class AdminHomeRepo {
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

  Future<Either<Failures, List<AnnounsModel>>> fetchWehreHouses({
    required String endPoint,
  });
  Future<bool> sendreports({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future saveUserDataLocal(UserModel user);
}

import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';

import '../../../../core/errors/error.dart';

abstract class HomeRepo {
  Future<Either<Failures, UserModel>> fetchData({required String endPoint});
  Future<Either<Failures, UserModel>> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

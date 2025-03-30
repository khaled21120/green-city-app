import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserModel>> signUp({
    required Map<String, dynamic> data,
    required String endPoint,
    String? token,
  });
  Future<Either<Failures, UserModel>> logIn({
    required String endPoint,
    required String email,
    required String password,
  });
  Future saveUserDataLocal(UserModel user);

  Future<void> logOut();

  Future<void> deleteAccount({required String endPoint});
}

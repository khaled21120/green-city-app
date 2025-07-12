import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> signUp({
    required Map<String, dynamic> data,
    required String endPoint,
  });
  Future<Either<Failure, UserModel>> logIn({
    required String endPoint,
    required String email,
    required String password,
  });
  Future saveUserDataLocal(UserModel user);

  Future<void> logOut();
  Future<Either<Failure, void>> forgetPassword({
    required String endPoint,
    required String email,
    required String redirectUrl,
  });

  Future<Either<Failure, void>> resetPassword({
    required String endPoint,
    required String token,
    required String email,
    required String newPassword,
  });
  Future<bool> deleteAccount({required String endPoint});
}

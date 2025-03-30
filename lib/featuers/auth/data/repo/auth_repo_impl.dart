import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants.dart';
import '../../../../core/errors/error.dart';
import '../../../../core/services/back_auth_service.dart';
import '../../../../core/services/prefs_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required this.backendAuthService});
  final BackendAuthService backendAuthService;

  @override
  Future<Either<Failures, UserModel>> logIn({
    required String endPoint,
    required String email,
    required String password,
  }) async {
    try {
      await backendAuthService.logIn(
        endPoint: endPoint,
        email: email,
        password: password,
      );
      final userData = await backendAuthService.fetchUserData(
        endPoint: endPoint,
      );
      final user = UserModel.fromJson(userData);
      await saveUserDataLocal(user);
      return Right(user);
    } on Exception {
      return Left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Failures, UserModel>> signUp({
    required Map<String, dynamic> data,
    required String endPoint,
    String? token,
  }) async {
    try {
      await backendAuthService.signUp(
        user: UserModel.fromJson(data),
        endPoint: endPoint,
        token: token,
      );
      final userData = await backendAuthService.fetchUserData(
        endPoint: endPoint,
      );
      final user = UserModel.fromJson(userData);
      await saveUserDataLocal(user);
      return Right(user);
    } on Exception {
      return Left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future saveUserDataLocal(UserModel user) async {
    final data = jsonEncode(user.toJson());
    await PrefsService.setString(Constants.kUserData, data);
    await PrefsService.isLogIn(true);
  }

  @override
  Future<void> deleteAccount({required String endPoint}) async {
    await PrefsService.clear();
    await backendAuthService.deleteUser(endPoint: endPoint);
  }

  @override
  Future<void> logOut() async {
    await backendAuthService.logOut();
  }
}

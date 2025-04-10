import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/errors/error.dart';
import '../../../../core/services/back_auth_service.dart';
import '../../../../core/services/prefs_service.dart';
import 'auth_repo.dart';
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
      // await backendAuthService.logIn(
      //   endPoint: endPoint,
      //   email: email,
      //   password: password,
      // );
      // final userData = await backendAuthService.fetchUserData(
      //   endPoint: endPoint,
      // );
      String jsonString = await rootBundle.loadString(Constants.db);
      // Decode the JSON string
      var jsonData = json.decode(jsonString);

      final userData = jsonData['users'][4] as Map<String, dynamic>;

      final user = UserModel.fromJson(userData);
      await isLogin();
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(
        ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}'),
      );
    }
  }

  @override
  Future<Either<Failures, UserModel>> signUp({
    required Map<String, dynamic> data,
    required String endPoint,
    String? token,
  }) async {
    try {
      // await backendAuthService.signUp(
      //   user: UserModel.fromJson(data),
      //   endPoint: endPoint,
      //   token: token,
      // );
      String jsonString = await rootBundle.loadString(Constants.db);
      // Decode the JSON string
      var jsonData = json.decode(jsonString);

      final userData = jsonData['users'][1] as Map<String, dynamic>;
      // await backendAuthService.fetchUserData(
      //   endPoint: endPoint,
      // );
      final user = UserModel.fromJson(userData);
      await isLogin();
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(
        ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى ${e.errMsg}'),
      );
    }
  }

  @override
  Future isLogin() async {
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

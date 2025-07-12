import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_city/core/utils/endpoints.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/errors/error.dart';
import '../../../../core/services/back_auth_service.dart';
import '../../../../core/services/prefs_service.dart';
import 'auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.apiAuthService);
  final ApiAuthService apiAuthService;
  final storage = const FlutterSecureStorage();

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String endPoint,
    required String email,
    required String password,
  }) async {
    try {
      await apiAuthService.logIn(
        endPoint: endPoint,
        email: email,
        password: password,
      );
      final userData = await apiAuthService.fetchUserData(
        endPoint: Endpoints.getUserData,
      );
      final user = UserModel.fromJson(userData);
      await saveUserDataLocal(user);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp({
    required Map<String, dynamic> data,
    required String endPoint,
  }) async {
    try {
      await apiAuthService.signUp(user: data, endPoint: endPoint);
      final userData = await apiAuthService.fetchUserData(
        endPoint: Endpoints.getUserData,
      );
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
  Future<bool> deleteAccount({required String endPoint}) async {
    try {
      await PrefsService.clear();
      await storage.deleteAll();
      await apiAuthService.deleteUser(endPoint: endPoint);
      return true;
    } on ServerFailure {
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    await apiAuthService.logOut();
  }

  @override
  Future<Either<Failure, void>> forgetPassword({
    required String endPoint,
    required String email,
    required String redirectUrl,
  }) async {
    try {
      final response = await apiAuthService.forgetPassword(
        endPoint: endPoint,
        email: email,
        redirectUrl: redirectUrl,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String endPoint,
    required String token,
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await apiAuthService.resetPassword(
        endPoint: endPoint,
        token: token,
        email: email,
        newPassword: newPassword,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

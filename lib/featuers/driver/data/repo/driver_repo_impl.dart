import 'package:dartz/dartz.dart';
import 'package:green_city/core/errors/error.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

import '../../../../core/services/data_base_service.dart';

class DriverRepoImpl extends DriverRepo {
  final DatabaseService databaseService;

  DriverRepoImpl(this.databaseService);
  @override
  Future<Either<Failures, List<dynamic>>> fetchTasks({
    required String endPoint,
  }) async {
    try {
      final reports = await databaseService.fetchListData(endPoint: endPoint);
      return Right(reports);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }

  @override
  Future<bool> sendDriverReports({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await databaseService.sendData(
        endPoint: endPoint,
        data: data,
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<bool> completeTask({required String endPoint, required int id}) async {
    try {
      final res = await databaseService.postByID(
        endPoint: endPoint,
        id: id.toString(),
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<bool> acceptTask({required String endPoint, required int id}) async {
    try {
      final res = await databaseService.postByID(
        endPoint: endPoint,
        id: id.toString(),
      );
      return res;
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }
}

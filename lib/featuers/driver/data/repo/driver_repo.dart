import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';

abstract class DriverRepo {
  Future<bool> acceptTask({required String endPoint, required int id});
  Future<Either<Failure, bool>> completeTask({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, List<dynamic>>> fetchTasks({required String endPoint});
  Future<Either<Failure, bool>> sendDriverReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

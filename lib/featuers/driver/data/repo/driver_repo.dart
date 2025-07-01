import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';

abstract class DriverRepo {
  Future<bool> acceptTask({required String endPoint, required int id});
 Future<Either<Failures, bool>>completeTask({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failures, List<dynamic>>> fetchTasks({
    required String endPoint,
  });
  Future<Either<Failures, bool>> sendDriverReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

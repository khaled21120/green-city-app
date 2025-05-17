import 'package:dartz/dartz.dart';

import '../../../../core/errors/error.dart';

abstract class DriverRepo {
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failures, List<dynamic>>> fetchTasks({
    required String endPoint,
  });
  Future<bool> sendDriverReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

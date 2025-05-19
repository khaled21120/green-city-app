import 'package:dartz/dartz.dart';
import '../../../../core/errors/error.dart';
import '../../../user/data/models/user_reports_model.dart';

abstract class AdminRepo {
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failures, List<UserReportsModel>>> fetchWehreHouses({
    required String endPoint,
  });
  Future<bool> sendAdminReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

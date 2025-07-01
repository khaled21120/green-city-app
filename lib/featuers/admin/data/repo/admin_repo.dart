import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/admin/data/models/warehouses_model.dart';
import '../../../../core/errors/error.dart';

abstract class AdminRepo {
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  });

  Future<Either<Failures, List<WarehousesModel>>> fetchWehreHouses({
    required String endPoint,
  });
  Future<Either<Failures, bool>> sendAdminReports({
    required String endPoint,
    required Map<String, dynamic> data,
  });
}

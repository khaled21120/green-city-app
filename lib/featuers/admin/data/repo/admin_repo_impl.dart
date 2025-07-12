import 'package:dartz/dartz.dart';
import 'package:green_city/featuers/admin/data/models/warehouses_model.dart';

import '../../../../core/errors/error.dart';
import '../../../../core/services/data_base_service.dart';
import 'admin_repo.dart';

class AdminRepoImpl extends AdminRepo {
  AdminRepoImpl(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<Failure, bool>> sendAdminReports({
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
  Future updateData({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      await databaseService.updateData(endPoint: endPoint, data: data);
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failure, List<WarehousesModel>>> fetchWehreHouses({
    required String endPoint,
  }) async {
    try {
      final warehouses = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final warehouse =
          warehouses.map((e) => WarehousesModel.fromJson(e)).toList();
      return Right(warehouse);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }
}

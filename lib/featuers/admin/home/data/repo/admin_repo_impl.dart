import 'package:dartz/dartz.dart';

import '../../../../../core/errors/error.dart';
import '../../../../../core/services/data_base_service.dart';
import '../../../../user/home/data/models/user_reports_model.dart';
import 'admin_repo.dart';

class AdminRepoImpl extends AdminRepo {
  AdminRepoImpl(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<bool> sendAdminReports({
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
      await databaseService.updateData(
        endPoint: endPoint,
        data: data,
        isImage: false,
      );
    } on ServerFailure catch (e) {
      throw ServerFailure(e.errMsg);
    }
  }

  @override
  Future<Either<Failures, List<UserReportsModel>>> fetchWehreHouses({
    required String endPoint,
  }) async {
    try {
      final anounnsList = await databaseService.fetchListData(
        endPoint: endPoint,
      );
      final anounns =
          anounnsList.map((e) => UserReportsModel.fromJson(e)).toList();
      return Right(anounns);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errMsg));
    }
  }
}


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/admin/data/models/admin_reports_model.dart';
import 'package:green_city/featuers/admin/data/repo/admin_repo.dart';

import '../../../../../core/errors/error.dart';
import '../../../data/models/warehouses_model.dart';

part 'admin_reports_state.dart';

class AdminReportsCubit extends Cubit<AdminReportsState> {
  AdminReportsCubit(this.adminHomeRepo) : super(AdminReportsInitial());
  final AdminRepo adminHomeRepo;
  List<WarehousesModel> warehouses = [];

  void sendAdminReport(AdminReportsModel adminReport) async {
    emit(AdminReportsLoading());
    try {
      final res = await adminHomeRepo.sendAdminReports(
        endPoint: Endpoints.sendAdminReports,
        data: adminReport.toJson(),
      );
      res.fold((failure) => emit(AdminReportsFailure(failure.errMsg)), (data) {
        emit(const AdminReportsSuccess('Report sent successfully'));
      });
    } on ServerFailure {
      emit(const AdminReportsFailure('حدث خطأ ما. الرجاء المحاولة مرة اخرى'));
    }
  }

  void fetchWarehouses() async {
    emit(AdminReportsLoading());
    final result = await adminHomeRepo.fetchWehreHouses(
      endPoint: Endpoints.getWarehouses,
    );
    result.fold((failure) => emit(FetchWarehousesFailure(failure.errMsg)), (
      warehouses,
    ) {
      this.warehouses = warehouses;
      emit(FetchWarehousesSuccess(warehouses));
    });
  }
}

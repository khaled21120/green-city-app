import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/admin/home/data/repo/admin_repo.dart';

part 'admin_reports_state.dart';

class AdminReportsCubit extends Cubit<AdminReportsState> {
  AdminReportsCubit(this.adminHomeRepo) : super(AdminReportsInitial());
  final AdminRepo adminHomeRepo;

  void sendAdminReport({required Map<String, dynamic> data}) async {
    emit(AdminReportsLoading());
    final isSend = await adminHomeRepo.sendAdminReports(
      endPoint: Endpoints.sendAdminReports,
      data: data,
    );
    if (isSend) {
      emit(const AdminReportsSuccess('تم ارسال التقرير بنجاح'));
    } else {
      emit(const AdminReportsFailure('حدث خطأ ما الرجاء المحاولة مرة اخرى'));
    }
  }
}

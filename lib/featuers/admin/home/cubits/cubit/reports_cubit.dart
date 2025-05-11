import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/admin/home/data/repo/admin_home_repo.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.adminHomeRepo) : super(ReportsInitial());
  final AdminHomeRepo adminHomeRepo;

  void sendReport({required Map<String, dynamic> data}) async {
    emit(ReportsLoading());
    final isSend = await adminHomeRepo.sendreports(
      endPoint: Endpoints.report,
      data: data,
    );
    if (isSend) {
      emit(const ReportsSuccess('تم ارسال التقرير بنجاح'));
    } else {
      emit(const ReportsFailure('حدث خطأ ما الرجاء المحاولة مرة اخرى'));
    }
  }
}

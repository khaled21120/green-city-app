import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

import '../../../../core/utils/endpoints.dart';

part 'driver_reports_state.dart';

class DriverReportsCubit extends Cubit<DriverReportsState> {
  DriverReportsCubit(this.driverRepo) : super(DriverReportsInitial());
  final DriverRepo driverRepo;

  Future<void> sendDriverReports({required Map<String, dynamic> data}) async {
    emit(DriverReportsLoading());
    final result = await driverRepo.sendDriverReports(
      endPoint: Endpoints.sendDriverReports,
      data: data,
    );
    if (result) {
      emit(const DriverReportsSuccess('تم ارسال التقرير بنجاح'));
    } else {
      emit(const DriverReportsFailure('حدث خطأ ما الرجاء المحاولة مرة اخرى'));
    }
  }
}

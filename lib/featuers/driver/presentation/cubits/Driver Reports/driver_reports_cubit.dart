import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

import '../../../../../core/utils/endpoints.dart';

part 'driver_reports_state.dart';

class DriverReportsCubit extends Cubit<DriverReportsState> {
  DriverReportsCubit(this.driverRepo) : super(DriverReportsInitial());
  final DriverRepo driverRepo;


  void completeTask({
    required String name,
    required String desc,
    required String sentAt,
    required int announcementsID,
    required File photoFile,
  }) async {
    emit(CompleteTaskLoading());
    final file = await MultipartFile.fromFile(
      photoFile.path,
      filename: photoFile.path.split('/').last,
    );
    final result = await driverRepo.completeTask(
      endPoint: Endpoints.completeDriverTask,
      data: {
        'driverName': name,
        'reportDESC': desc,
        'sentAt': sentAt,
        'announcementsID': announcementsID,
        'photoFile': file,
      },
    );
    if (result) {
      emit(const CompleteTaskSuccess('تم اكمال المهمة بنجاح'));
    } else {
      emit(const CompleteTaskFailure('حدث خطأ ما الرجاء المحاولة مرة اخرى'));
    }
  }
}

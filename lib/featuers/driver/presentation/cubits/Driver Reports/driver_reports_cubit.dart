import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';


part 'driver_reports_state.dart';

class DriverReportsCubit extends Cubit<DriverReportsState> {
  DriverReportsCubit(this.driverRepo) : super(DriverReportsInitial());
  final DriverRepo driverRepo;

  void completeTask({
    required int id,
    required String name,
    required String desc,
    required String sentAt,
    required int announcementsID,
    required File photoFile,
    required String endPoint
  }) async {
    emit(CompleteTaskLoading());
    final file = await MultipartFile.fromFile(
      photoFile.path,
      filename: photoFile.path.split('/').last,
    );
    final result = await driverRepo.completeTask(
      endPoint: '$endPoint/$id',
      data: {
        'driverName': name,
        'reportDESC': desc,
        'sentAt': sentAt,
        'announcementsID': announcementsID,
        'photoFile': file,
      },
    );
    result.fold(
      (l) => emit(CompleteTaskFailure(l.errMsg)),
      (r) => emit(const CompleteTaskSuccess('تم اكمال المهمة بنجاح')),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

import '../../../../user/data/models/user_reports_model.dart';

part 'paid_tasks_state.dart';

class PaidTasksCubit extends Cubit<PaidTasksState> {
  PaidTasksCubit(this.driverRepo) : super(PaidTasksInitial());
  final DriverRepo driverRepo;

  void getAllPaidTasks() async {
    emit(PaidTasksLoading());
    final res = await driverRepo.fetchTasks(
      endPoint: Endpoints.getAllPayedReports,
    );
    res.fold((failure) => emit(PaidTasksFailure(failure.errMsg)), (tasks) {
      final driverTasks =
          tasks.map((e) => UserReportsModel.fromJson(e)).toList();
      emit(PaidTasksSuccess(driverTasks));
    });
  }

  void getAcceptedPaidTasks() async {
    emit(PaidTasksLoading());
    final res = await driverRepo.fetchTasks(
      endPoint: Endpoints.getAcceptedPayedReports,
    );
    res.fold((failure) => emit(PaidTasksFailure(failure.errMsg)), (tasks) {
      final driverTasks =
          tasks.map((e) => UserReportsModel.fromJson(e)).toList();
      emit(PaidTasksSuccess(driverTasks));
    });
  }

  void acceptPaidTasks(int id) async {
    try {
      emit(PaidTasksLoading());
      final res = await driverRepo.acceptTask(
        endPoint: Endpoints.acceptPayedReports,
        id: id,
      );
      if (res) {
        emit(const AcceptPaidTasksSuccess('Task Sent Successfully'));
      } else {
        emit(const AcceptPaidTasksFailure(''));
      }
    } catch (e) {
      emit(const AcceptPaidTasksFailure(''));
    }
  }
}

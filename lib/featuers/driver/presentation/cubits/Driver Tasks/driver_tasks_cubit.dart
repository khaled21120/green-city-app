import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

import '../../../../user/data/models/user_reports_model.dart';

part 'driver_tasks_state.dart';

class DriverTasksCubit extends Cubit<DriverTasksState> {
  DriverTasksCubit(this.driverRepo) : super(DriverTasksInitial());
  final DriverRepo driverRepo;

  void getDriverTasks() async {
    emit(DriverTasksLoading());
    final result = await driverRepo.fetchTasks(endPoint: Endpoints.driverTasks);
    result.fold((failure) => emit(DriverTasksFailure(failure.errMsg)), (tasks) {
      final driverTasks =
          tasks.map((e) => UserReportsModel.fromJson(e)).toList();
      emit(DriverTasksSuccess(driverTasks));
    });
  }

  void getAllTasks() async {
    emit(DriverTasksLoading());
    final result = await driverRepo.fetchTasks(
      endPoint: Endpoints.allDriversTasks,
    );
    result.fold((failure) => emit(AllDriversTasksFailure(failure.errMsg)), (
      tasks,
    ) {
      final driverTasks =
          tasks.map((e) => UserReportsModel.fromJson(e)).toList();
      emit(AllDriversTasksSuccess(driverTasks));
    });
  }

  void acceptTask({required int id}) async {
    emit(AcceptTaskLoading());
    final result = await driverRepo.acceptTask(
      endPoint: Endpoints.acceptDriverTask,
      id: id,
    );
    if (result) {
      emit(const AcceptTaskSuccess('تم قبول المهمة بنجاح'));
    } else {
      emit(const AcceptTaskFailure('حدث خطأ ما الرجاء المحاولة مرة اخرى'));
    }
  }
}

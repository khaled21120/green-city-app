import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/driver/data/repo/driver_repo.dart';

part 'driver_tasks_state.dart';

class DriverTasksCubit extends Cubit<DriverTasksState> {
  DriverTasksCubit(this.driverRepo) : super(DriverTasksInitial());
  final DriverRepo driverRepo;

  void getDriverTasks() async {
    emit(DriverTasksLoading());
    final result = await driverRepo.fetchTasks(endPoint: Endpoints.driverTasks);
    result.fold(
      (failure) => emit(DriverTasksFailure(failure.errMsg)),
      (tasks) => emit(DriverTasksSuccess(tasks)),
    );
  }

  void getAllTasks() async {
    emit(DriverTasksLoading());
    final result = await driverRepo.fetchTasks(
      endPoint: Endpoints.allDriversTasks,
    );
    result.fold(
      (failure) => emit(AllDriversTasksFailure(failure.errMsg)),
      (tasks) => emit(AllDriversTasksSuccess(tasks)),
    );
  }
}

part of 'driver_tasks_cubit.dart';

sealed class DriverTasksState extends Equatable {
  const DriverTasksState();

  @override
  List<Object> get props => [];
}

final class DriverTasksInitial extends DriverTasksState {}

final class DriverTasksLoading extends DriverTasksState {}

final class DriverTasksSuccess extends DriverTasksState {
  final List<UserReportsModel> tasks;
  const DriverTasksSuccess(this.tasks);
}

final class DriverTasksFailure extends DriverTasksState {
  final String errMsg;
  const DriverTasksFailure(this.errMsg);
}

final class AllDriversTasksSuccess extends DriverTasksState {
  final List<UserReportsModel> tasks;
  const AllDriversTasksSuccess(this.tasks);
}

final class AllDriversTasksFailure extends DriverTasksState {
  final String errMsg;
  const AllDriversTasksFailure(this.errMsg);
}

final class AcceptTaskLoading extends DriverTasksState {}

final class AcceptTaskSuccess extends DriverTasksState {
  final String message;
  const AcceptTaskSuccess(this.message);
}

final class AcceptTaskFailure extends DriverTasksState {
  final String message;
  const AcceptTaskFailure(this.message);
}

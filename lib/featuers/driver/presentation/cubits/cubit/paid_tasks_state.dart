part of 'paid_tasks_cubit.dart';

sealed class PaidTasksState extends Equatable {
  const PaidTasksState();

  @override
  List<Object> get props => [];
}

final class PaidTasksInitial extends PaidTasksState {}

final class PaidTasksLoading extends PaidTasksState {}
final class AcceptPaidTasksLoading extends PaidTasksState {}

final class PaidTasksFailure extends PaidTasksState {
  final String errMsg;
  const PaidTasksFailure(this.errMsg);
}

final class PaidTasksSuccess extends PaidTasksState {
  final List<UserReportsModel> tasks;
  const PaidTasksSuccess(this.tasks);
}

final class AcceptPaidTasksFailure extends PaidTasksState {
  final String errMsg;
  const AcceptPaidTasksFailure(this.errMsg);
}

final class AcceptPaidTasksSuccess extends PaidTasksState {
  final String message;
  const AcceptPaidTasksSuccess(this.message);
}

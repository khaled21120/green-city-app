part of 'driver_reports_cubit.dart';

sealed class DriverReportsState extends Equatable {
  const DriverReportsState();

  @override
  List<Object> get props => [];
}

final class DriverReportsInitial extends DriverReportsState {}


final class CompleteTaskLoading extends DriverReportsState {}

final class CompleteTaskSuccess extends DriverReportsState {
  final String message;
  const CompleteTaskSuccess(this.message);
}

final class CompleteTaskFailure extends DriverReportsState {
  final String message;
  const CompleteTaskFailure(this.message);
}

part of 'driver_reports_cubit.dart';

sealed class DriverReportsState extends Equatable {
  const DriverReportsState();

  @override
  List<Object> get props => [];
}

final class DriverReportsInitial extends DriverReportsState {}

final class DriverReportsLoading extends DriverReportsState {}

final class DriverReportsSuccess extends DriverReportsState {
  final String message;
  const DriverReportsSuccess(this.message);
}

final class DriverReportsFailure extends DriverReportsState {
  final String errMsg;
  const DriverReportsFailure(this.errMsg);
}

part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}

final class ReportsLoading extends ReportsState {}

final class ReportsSuccess extends ReportsState {
  final String message;
  const ReportsSuccess(this.message);
}

final class ReportsFailure extends ReportsState {
  final String message;
  const ReportsFailure(this.message);
}

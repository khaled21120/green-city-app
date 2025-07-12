part of 'user_reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}

final class ReportsLoading extends ReportsState {}

final class ReportsSend extends ReportsState {
  final String message;
  const ReportsSend(this.message);
}

final class FetchReportsSuccess extends ReportsState {
  final List<UserReportsModel> announsList;
  const FetchReportsSuccess(this.announsList);
}
final class FetchSubSuccess extends ReportsState {
  final UserReportsModel subscribe;
  const FetchSubSuccess(this.subscribe);
}

final class ReportsError extends ReportsState {
  final String message;
  const ReportsError(this.message);
}
final class CancelSubscription extends ReportsState {
  final String message;
  const CancelSubscription(this.message);
}

final class FetchRegionsSuccess extends ReportsState {
  final List<RegionModel> regionsList;
  const FetchRegionsSuccess(this.regionsList);
}

final class FetchRegionsError extends ReportsState {
  final String message;
  const FetchRegionsError(this.message);
}

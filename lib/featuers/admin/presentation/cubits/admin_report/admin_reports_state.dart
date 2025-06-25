part of 'admin_reports_cubit.dart';

sealed class AdminReportsState extends Equatable {
  const AdminReportsState();

  @override
  List<Object> get props => [];
}

final class AdminReportsInitial extends AdminReportsState {}

final class AdminReportsLoading extends AdminReportsState {}

final class AdminReportsSuccess extends AdminReportsState {
  final String message;
  const AdminReportsSuccess(this.message);
}

final class AdminReportsFailure extends AdminReportsState {
  final String message;
  const AdminReportsFailure(this.message);
}

final class FetchWarehousesFailure extends AdminReportsState {
  final String message;
  const FetchWarehousesFailure(this.message);
}

final class FetchWarehousesSuccess extends AdminReportsState {
  final List<WarehousesModel> warehousesList;
  const FetchWarehousesSuccess(this.warehousesList);
}

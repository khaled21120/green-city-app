part of 'activities_cubit.dart';

sealed class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

final class ActivitiesInitial extends ActivitiesState {}

final class ActivitiesLoaded extends ActivitiesState {
  final List<ActivitiesModel> activities;
  const ActivitiesLoaded(this.activities);
}

final class ActivitiesError extends ActivitiesState {
  final String message;
  const ActivitiesError(this.message);
}

final class ActivitiesLoading extends ActivitiesState {}

final class ActivityJoined extends ActivitiesState {
  final String message;
  const ActivityJoined(this.message);
}

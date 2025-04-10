part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<UserNotifiyModel> privateNotifications;
  final List<PublicNotifiyModel> publicNotifications;

  const NotificationsLoaded({
    required this.privateNotifications,
    required this.publicNotifications,
  });
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);
}

part of 'notify_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<UserNotifiyModel> privateNotifications;
  final List<UserNotifiyModel> publicNotifications;

  const NotificationsLoaded({
    required this.privateNotifications,
    required this.publicNotifications,
  });
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);
}

class NotificationDeleted extends NotificationsState {
  final String message;
  const NotificationDeleted(this.message);
}

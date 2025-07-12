import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/data/models/user_notifiy_model.dart';
import 'package:green_city/featuers/user/data/repo/user_repo.dart';

import '../../../../../core/utils/endpoints.dart';

part 'notify_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.homeRepo) : super(NotificationsInitial());

  final UserRepo homeRepo;

  List<UserNotifiyModel> _privateNotifications = [];
  List<UserNotifiyModel> _publicNotifications = [];

  void loadAllNotifications() async {
    emit(NotificationsLoading());

    final privateResult = await homeRepo.fetchNotifications(
      endPoint: Endpoints.userNotifications,
    );
    final publicResult = await homeRepo.fetchNotifications(
      endPoint: Endpoints.publicNotifications,
    );

    privateResult.fold(
      (error) => emit(NotificationsError(error.errMsg)),
      (data) =>
          _privateNotifications =
              data.map((e) => UserNotifiyModel.fromJson(e)).toList(),
    );

    publicResult.fold(
      (error) => emit(NotificationsError(error.errMsg)),
      (data) =>
          _publicNotifications =
              data.map((e) => UserNotifiyModel.fromJson(e)).toList(),
    );

    emit(
      NotificationsLoaded(
        privateNotifications: _privateNotifications,
        publicNotifications: _publicNotifications,
      ),
    );
  }

  void deleteNotification({required int id, required isPublic}) async {
    emit(NotificationsLoading());
    late bool isDeleted;
    isPublic
        ? isDeleted = await homeRepo.hideNotification(
          endPoint: Endpoints.hidePublicNotifications,
          id: id,
        )
        : isDeleted = await homeRepo.deleteNotification(
          endPoint: Endpoints.userNotifications,
          id: id,
        );

    if (isDeleted) {
      loadAllNotifications();
      emit(const NotificationDeleted('Notification deleted successfully'));
    } else {
      emit(const NotificationsError('Failed to delete notification'));
    }
  }
}

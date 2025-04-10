import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/home/data/models/user_notifiy_model.dart';
import 'package:green_city/featuers/home/data/models/public_notifiy_model.dart';
import 'package:green_city/featuers/home/data/repo/home_repo.dart';

import '../../../../../core/utils/endpoints.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.homeRepo) : super(NotificationsInitial());

  final HomeRepo homeRepo;

  List<UserNotifiyModel> _privateNotifications = [];
  List<PublicNotifiyModel> _publicNotifications = [];

  void loadAllNotifications() async {
    emit(NotificationsLoading());

    final privateResult = await homeRepo.fetchUserNotifications(
      endPoint: Endpoints.userNotifications,
    );
    final publicResult = await homeRepo.fetchPublicNotifications(
      endPoint: Endpoints.publicNotifications,
    );

    privateResult.fold(
      (error) => emit(NotificationsError(error.errMsg)),
      (data) => _privateNotifications = data,
    );

    publicResult.fold(
      (error) => emit(NotificationsError(error.errMsg)),
      (data) => _publicNotifications = data,
    );

    if (_privateNotifications.isNotEmpty || _publicNotifications.isNotEmpty) {
      emit(
        NotificationsLoaded(
          privateNotifications: _privateNotifications,
          publicNotifications: _publicNotifications,
        ),
      );
    } else {
      emit(const NotificationsError('No notifications found.'));
    }
  }
}

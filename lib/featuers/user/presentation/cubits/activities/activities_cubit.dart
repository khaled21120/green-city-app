import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../data/models/activities_model.dart';
import '../../../data/repo/user_repo.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this.homeRepo) : super(ActivitiesInitial());
  final UserRepo homeRepo;

void getAllActivities() async {
  emit(ActivitiesLoading());

  final allActivitiesResult = await homeRepo.fetchActivities(
    endPoint: Endpoints.activities,
  );
  final myActivitiesResult = await homeRepo.fetchActivities(
    endPoint: Endpoints.myActivities,
  );

  if (allActivitiesResult.isLeft()) {
    emit(ActivitiesError(allActivitiesResult.fold((l) => l.errMsg, (_) => '')));
    return;
  }

  if (myActivitiesResult.isLeft()) {
    emit(ActivitiesError(myActivitiesResult.fold((l) => l.errMsg, (_) => '')));
    return;
  }

  final allActivities = allActivitiesResult.getOrElse(() => []);
  final myActivities = myActivitiesResult.getOrElse(() => []);

  // Filter logic
  final myActivityIds = myActivities.map((activity) => activity.id).toSet();
  final notMyActivities = allActivities
      .where((activity) => !myActivityIds.contains(activity.id))
      .toList();

  emit(ActivitiesLoaded(notMyActivities));
}
  void getMyActivities() async {
    emit(ActivitiesLoading());
    final myActivities = await homeRepo.fetchActivities(
      endPoint: Endpoints.myActivities,
    );
    myActivities.fold(
      (failure) => emit(ActivitiesError(failure.errMsg)),
      (myActivities) => emit(MyActivitiesLoaded(myActivities)),
    );
  }

  void subscribe({required int activityId}) async {
    emit(ActivitiesLoading());
    final result = await homeRepo.editActivity(
      endPoint: Endpoints.activities,
      id: '/$activityId/subscribe',
    );
    result.fold(
      (error) => emit(ActivitiesError(error.errMsg)),
      (data) => emit(const ActivityJoined('تم الانضمام للنشاط بنجاح')),
    );
  }

  void unSubscribe({required int activityId}) async {
    emit(ActivitiesLoading());
    final result = await homeRepo.editActivity(
      endPoint: Endpoints.myActivities,
      id: '/$activityId/unsubscribe',
    );
    result.fold(
      (error) => emit(ActivitiesError(error.errMsg)),
      (data) =>
          emit(const ActivityUnSubscribe('تم الغاء الأشتراك في النشاط بنجاح')),
    );
  }
}

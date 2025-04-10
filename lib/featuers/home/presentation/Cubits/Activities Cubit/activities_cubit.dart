import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';

import '../../../data/models/activities_model.dart';
import '../../../data/repo/home_repo.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this.homeRepo) : super(ActivitiesInitial());
  final HomeRepo homeRepo;

  void getActivities() async {
    emit(ActivitiesLoading());
    final userActivities = await homeRepo.fetchActivities(
      endPoint: Endpoints.activities,
    );
    userActivities.fold(
      (error) => emit(ActivitiesError(error.errMsg)),
      (data) => emit(ActivitiesLoaded(data)),
    );
  }
}

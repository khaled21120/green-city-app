import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../domain/repo/home_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.homeRepo) : super(ProfileStateInitial());
  final HomeRepo homeRepo;

  Future<void> updateData({required Map<String, dynamic> data}) async {
    emit(ProfileLoading());
    try {
      final user = await homeRepo.updateData(
        endPoint: Endpoints.usersEndpoint,
        data: data,
      );
      user.fold(
        (error) => emit(ProfileUpdateDataFailure(error.errMsg)),
        (data) => emit(ProfileUpdateDataSuccess(data)),
      );
    } on Exception catch (e) {
      emit(ProfileUpdateDataFailure(e.toString()));
    }
  }
}

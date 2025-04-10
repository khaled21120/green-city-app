import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/endpoints.dart';
import '../../auth/data/models/user_model.dart';
import '../../home/data/repo/home_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.homeRepo) : super(ProfileStateInitial());

  final HomeRepo homeRepo;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> getUserData() async {
    emit(ProfileLoading());
    final result = await homeRepo.fetchUserData(
      endPoint: Endpoints.usersEndpoint,
    );
    result.fold((error) => emit(ProfileUpdateDataFailure(error.errMsg)), (
      user,
    ) {
      _currentUser = user;
      emit(FetchDataSuccess(user));
    });
  }

  Future<void> updateData({required Map<String, dynamic> data}) async {
    emit(ProfileLoading());
    final result = await homeRepo.updateUserData(
      endPoint: Endpoints.usersEndpoint,
      data: data,
    );
    result.fold((error) => emit(ProfileUpdateDataFailure(error.errMsg)), (
      user,
    ) {
      _currentUser = user;
      emit(ProfileUpdateDataSuccess(user));
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/auth/data/repo/auth_repo.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.homeRepo, this.authRepo) : super(ProfileStateInitial());

  final UserRepo homeRepo;
  final AuthRepo authRepo;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> fetchUserData() async {
    emit(FetchDataLoading());
    final result = await homeRepo.fetchUserData(
      endPoint: Endpoints.getUserData,
    );
    result.fold((error) => emit(FetchDataFailure(error.errMsg)), (user) {
      _currentUser = user;
      emit(FetchDataSuccess(user));
    });
  }

  Future<void> updateData({
    required dynamic data,
    required bool isImage,
  }) async {
    emit(FetchDataLoading());

    final result = await homeRepo.updateUserData(
      endPoint: Endpoints.getUserData,
      data: data,
      isImage: isImage,
    );

    result.fold(
      (error) {
        emit(UpdateDataFailure(error.errMsg));
      },
      (user) {
        _currentUser = user;
        emit(FetchDataSuccess(user));
        emit(UpdateDataSuccess(user));
      },
    );
  }

  Future<void> deleteAccount() async {
    emit(FetchDataLoading());
    final result = await authRepo.deleteAccount(
      endPoint: Endpoints.getUserData,
    );
    emit(LogOutSuccess(result));
  }
}

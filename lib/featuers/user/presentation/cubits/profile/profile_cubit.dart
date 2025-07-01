import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/auth/data/repo/auth_repo.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepo, this._authRepo) : super(ProfileStateInitial());

  final UserRepo _userRepo;
  final AuthRepo _authRepo;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> fetchUserData() async {
    emit(FetchDataLoading());
    final result = await _userRepo.fetchUserData(
      endPoint: Endpoints.getUserData,
    );
    result.fold((error) => emit(FetchDataFailure(error.errMsg)), (user) {
      _currentUser = user;
      emit(FetchDataSuccess(user));
    });
  }

  Future<void> updateProfile({
    required dynamic data,
    bool isImage = false,
  }) async {
    emit(FetchDataLoading());
    final result = await _userRepo.updateUserData(
      endPoint: Endpoints.getUserData,
      data: data,
      isImage: isImage,
    );

    result.fold((error) => emit(UpdateDataFailure(error.errMsg)), (user) {
      _currentUser = user;
      emit(UpdateDataSuccess(user));
    });
  }

  Future<void> deleteAccount() async {
    emit(FetchDataLoading());
    final result = await _authRepo.deleteAccount(
      endPoint: Endpoints.getUserData,
    );
    emit(LogOutSuccess(result));
  }
}

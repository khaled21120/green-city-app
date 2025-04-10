part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileStateInitial extends ProfileState {}

final class FetchDataSuccess extends ProfileState {
  final UserModel userModel;
  FetchDataSuccess(this.userModel);
}

final class ProfileLoading extends ProfileState {}

final class ProfileLogOut extends ProfileState {}

final class ProfileDeleteAccount extends ProfileState {}

final class ProfileUpdateDataSuccess extends ProfileState {
  final UserModel userModel;
  ProfileUpdateDataSuccess(this.userModel);
}

final class ProfileUpdateDataFailure extends ProfileState {
  final String errMsg;
  ProfileUpdateDataFailure(this.errMsg);
}

final class ProfileFetchDataFailure extends ProfileState {
  final String errMsg;
  ProfileFetchDataFailure(this.errMsg);
}

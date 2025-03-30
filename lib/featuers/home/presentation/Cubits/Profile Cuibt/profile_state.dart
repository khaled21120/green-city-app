part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileStateInitial extends ProfileState {}

final class FetchDataSuccess extends ProfileState {
  final UserModel userApiModel;
  FetchDataSuccess(this.userApiModel);
}

final class ProfileLoading extends ProfileState {}

final class ProfileLogOut extends ProfileState {}

final class ProfileDeleteAccount extends ProfileState {}

final class ProfileUpdateDataSuccess extends ProfileState {
  final UserModel userApiModel;
  ProfileUpdateDataSuccess(this.userApiModel);
}

final class ProfileUpdateDataFailure extends ProfileState {
  final String errorMessage;
  ProfileUpdateDataFailure(this.errorMessage);
}

part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class FetchDataSuccess extends ProfileState {
  final UserModel userModel;
  FetchDataSuccess(this.userModel);

  @override
  List<Object?> get props => [userModel];
}

class UpdateDataSuccess extends ProfileState {
  final UserModel userModel;
  UpdateDataSuccess(this.userModel);

  @override
  List<Object?> get props => [userModel];
}

class FetchDataLoading extends ProfileState {}

class LogOutSuccess extends ProfileState {
  final bool isLogOut;
  LogOutSuccess(this.isLogOut);
}

class FetchDataFailure extends ProfileState {
  final String errMsg;
  FetchDataFailure(this.errMsg);

  @override
  List<Object?> get props => [errMsg];
}

class UpdateDataFailure extends ProfileState {
  final String errMsg;
  UpdateDataFailure(this.errMsg);

  @override
  List<Object?> get props => [errMsg];
}

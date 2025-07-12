part of 'log_in_cubit.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInError extends LogInState {
  final String message;
  const LogInError(this.message);
}

final class LogInSuccess extends LogInState {
  final UserModel userModel;
  const LogInSuccess(this.userModel);
}

class ForgotPasswordSuccess extends LogInState {}

class ForgotPasswordError extends LogInState {
  final String message;
  const ForgotPasswordError(this.message);
}

class ResetPasswordSuccess extends LogInState {
  final String message;
  const ResetPasswordSuccess(this.message);
}

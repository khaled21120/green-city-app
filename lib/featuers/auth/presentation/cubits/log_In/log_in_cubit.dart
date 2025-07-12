import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/auth_repo.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this.authRepo) : super(LogInInitial());
  final AuthRepo authRepo;

  void logIn({required String email, required String password}) async {
    emit(LogInLoading());
    final res = await authRepo.logIn(
      endPoint: Endpoints.login,
      email: email,
      password: password,
    );
    res.fold(
      (failures) => emit(LogInError(failures.errMsg)),
      (userModel) => emit(LogInSuccess(userModel)),
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(LogInLoading());

    final res = await authRepo.forgetPassword(
      endPoint: Endpoints.forgotPassword,
      email: email,
      redirectUrl: 'greencity://reset-password', 
    );

    res.fold(
      (failure) => emit(ForgotPasswordError(failure.errMsg)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }

  // Add this method to LogInCubit
  Future<void> resetPassword({
    required String token,
    required String email,
    required String newPassword,
  }) async {
    emit(LogInLoading());

    final res = await authRepo.resetPassword(
      endPoint: Endpoints.resetPassword,
      token: token,
      email: email,
      newPassword: newPassword,
    );

    res.fold(
      (failure) => emit(LogInError(failure.errMsg)),
      (_) => emit(
        const ResetPasswordSuccess("Password reset successfully"),
      ), // Modify as needed
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/repo/auth_repo.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this.authRepo) : super(LogInInitial());
  final AuthRepo authRepo;

  void logIn({required String email, required String password}) async {
    emit(LogInLoading());
    final res = await authRepo.logIn(endPoint: Endpoints.login,email: email, password: password);
    res.fold(
      (failures) => emit(LogInError(failures.errMsg)),
      (userModel) => emit(LogInSuccess(userModel)),
    );
  }

  // void logInWthGoogle() async {
  //   emit(LogInLoading());
  //   final res = await authRepo.logInWithGoogle();
  //   res.fold(
  //     (failure) => emit(LogInError(failure.message)),
  //     (userEntity) => emit(LogInSuccess(userEntity)),
  //   );
  // }

  // void logInWthFaceBook() async {
  //   emit(LogInLoading());
  //   final res = await authRepo.logInWithFaceBook();
  //   res.fold(
  //     (failure) => emit(LogInError(failure.message)),
  //     (userEntity) => emit(LogInSuccess(userEntity)),
  //   );
  // }
}

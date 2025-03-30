import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/auth/domain/repo/auth_repo.dart';

import '../../../data/models/user_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;

  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    final res = await authRepo.signUp(
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
      endPoint: Endpoints.register,
    );
    res.fold(
      (failure) => emit(SignUpError(failure.errMsg)),
      (userModel) => emit(SignUpSuccess(userModel)),
    );
  }
}

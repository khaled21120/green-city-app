import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/services/prefs_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void isAuthenticated() {
    final isLogin = PrefsService.getBool(Constants.kIsLogin);
    // final hasToken = PrefsService.getToken();
    // emit(hasToken == null ? UnAuthenticated() : Authenticated());
    emit(isLogin ? Authenticated() : UnAuthenticated());
  }
}

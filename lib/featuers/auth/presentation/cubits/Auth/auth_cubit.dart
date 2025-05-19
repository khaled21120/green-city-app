import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_city/core/services/back_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.apiAuthService) : super(AuthInitial());
  final ApiAuthService apiAuthService;
  final storage = const FlutterSecureStorage();

  void logOut() async {
    await apiAuthService.logOut();
    emit(UnAuthenticated());
  }
}

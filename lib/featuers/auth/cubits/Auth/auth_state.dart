part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}


final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

final class Authenticated extends AuthState {}

final class UnAuthenticated extends AuthState {}

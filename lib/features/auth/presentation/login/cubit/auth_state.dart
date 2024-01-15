part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess(this.data);

  String? data;
}

class AuthFailure extends AuthState {
  AuthFailure(this.message);

  final String message;
}

class AuthShowHide extends AuthState {}

class AuthLogout extends AuthState {}

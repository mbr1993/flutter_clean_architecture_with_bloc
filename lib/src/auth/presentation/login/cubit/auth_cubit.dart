import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/logout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._postLogin, this._logoutUseCase) : super(AuthInitial());

  final LoginUseCase _postLogin;
  final LogoutUseCase _logoutUseCase;

  bool isPasswordHide = true;

  void showHidePassword() {
    emit(AuthInitial());
    isPasswordHide = !isPasswordHide;
    emit(AuthShowHide());
  }

  Future<void> login(LoginParams params) async {
    emit(AuthLoading());

    try {
      final result = await _postLogin.call(params);
      result.fold(
        (l) => emit(AuthFailure(l.toString())),
        (r) => emit(AuthSuccess(r.token)),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    isPasswordHide = true;

    try {
      final result = await _logoutUseCase.call(null);
      result.fold(
        (failure) => emit(AuthFailure(failure.toString())),
        (r) => emit(AuthLogout()),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }

    emit(AuthInitial());
  }
}

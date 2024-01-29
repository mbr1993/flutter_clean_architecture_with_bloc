import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._postLogin) : super(AuthInitial());

  final LoginUseCase _postLogin;

  bool isPasswordHide = true;

  void showHidePassword() {
    emit(AuthInitial());
    isPasswordHide = !isPasswordHide;
    emit(AuthShowHide());
  }

  Future<void> login(LoginParams params) async {
    emit(AuthLoading());
    final data = await _postLogin.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(AuthFailure(l.message ?? ''));
        }
      },
      (r) => emit(AuthSuccess(r.token)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    isPasswordHide = true;
    await HiveService().deleteValue(HiveKey.isLogin);
    await HiveService().deleteValue(HiveKey.token);
    emit(AuthLogout());
  }
}

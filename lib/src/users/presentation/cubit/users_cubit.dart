import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/get_users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/presentation/cubit/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._getUsers) : super(UsersLoading());

  final GetUsersUseCase _getUsers;

  Future<void> fetchUsers(UsersParam usersParam) async {
    if (usersParam.page == 1) {
      emit(UsersLoading());
    }

    final response = await _getUsers.call(usersParam);
    response.fold(
      (l) {
        if (l is ServerFailure) {
          emit(UsersError(l.message ?? ''));
        } else if (l is NoDataFailure) {
          emit(UsersEmpty());
        }
      },
      (r) {
        emit(UsersLoaded(r.userList!.cast<Users>()));
      },
    );
  }
}

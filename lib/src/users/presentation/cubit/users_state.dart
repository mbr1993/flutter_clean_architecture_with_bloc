import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
   const UsersLoaded(this.users);

  final List<Users> users;

  @override
  List<Object?> get props => [users];
}

class UsersError extends UsersState {
  const UsersError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class UsersEmpty extends UsersState {}

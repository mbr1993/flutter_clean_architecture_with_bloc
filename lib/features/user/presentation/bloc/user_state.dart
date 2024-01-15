 import 'package:equatable/equatable.dart';
 
 abstract  class UserState extends Equatable {
 const UserState();

 @override
 List<Object?> get props => [];

}

class UserStateInitial extends UserState{

  @override
  List<Object> get props => [];
}



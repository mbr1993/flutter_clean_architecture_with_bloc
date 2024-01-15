    
    
 import 'package:flutter_bloc/flutter_bloc.dart';
 import 'user_state.dart';
 import 'user_event.dart';

 class UserBloc extends Bloc<UserEvent,UserState> {

 UserBloc() : super(UserStateInitial()){
 
 
   //  Handle Events here
  //  on<TestEvent>((event, emit) async {
  //  emit(loginStateTest());
  //  });

}

}
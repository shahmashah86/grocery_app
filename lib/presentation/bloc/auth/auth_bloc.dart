// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';



import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/domain/auth/auth_repository/auth_repository.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final AuthRepository authRepository;
  AuthBloc(
    this.authRepository,
  ) : super(AuthInitial()) {
    on<AuthSignin>(_signin);
    on<listUsers>(_listusers);
    on<AuthSignUp>(_signup);

  }
  _signin(AuthSignin event, Emitter<AuthState> emit) async{
    try{
    
   var response= await authRepository.signinWithEmailandPass(username: event.username,password: event.password);
 

  if(response.containsKey('token')) {
       emit(AuthLoading());
        await Future.delayed(Duration(seconds: 3));
    bool isAdmin=response['isAdmin'];
    log(isAdmin.toString(),name: "admin");
    emit(Authsuccess(authModel:AuthModel(isAdmin: isAdmin) ));
  }
  else{

    log("invalid");
    emit(AuthError(errormsg: 'Invalid credentials'));
  }
  
  }
    catch(e){
  
      emit(AuthError(errormsg: e.toString()));
      log(e.toString());
    }
  }


    _signup(AuthSignUp event, Emitter<AuthState> emit) async{
    try{
    
   var response= await authRepository.signupWithEmailandPass(name: event.name,username: event.username,password: event.password);
 

  if(response.containsKey('token')) {
       emit(AuthLoading());
        await Future.delayed(Duration(seconds: 3));
    bool isAdmin=response['isAdmin'];
    log(isAdmin.toString(),name: "admin");
    emit(Authsuccess(authModel:AuthModel(isAdmin: isAdmin) ));
  }
  else{

    log("invalid");
    emit(AuthError(errormsg: 'Invalid credentials'));
  }
  
  }
    catch(e){
  
      emit(AuthError(errormsg: e.toString()));
      log(e.toString());
    }
  }



_listusers( listUsers event, Emitter<AuthState> emit) async {
 final currentstate=state;
    try{
      
    if(currentstate is UsersListstate){                                                              
      // emit(currentstate.copyWith(isLoading: true));
          final response=await authRepository.usersList();
    log('inside try of lisusers');
    emit(UsersListstate(users: response,isLoading: false));
    }
    else{
      
     
             final response=await authRepository.usersList();
    log('inside else of lisusers');

    emit(UsersListstate(users: response));   
    }

  }
  catch(e){
        log('inside error of list users');
    emit(UsersListError(e.toString()));
  }

}




}

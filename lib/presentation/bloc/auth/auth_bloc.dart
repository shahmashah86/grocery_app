// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

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
    on<ListUsers>(_listusers);
    on<AuthSignUp>(_signup);
    on<UploadProfile>(_profileimageUpload);
    on<Deleteuser>(_deleteuser);
    on<Resetpassword>(_resetpassword);
    on<Updateuser>(_updateuser);
  }
  _signin(AuthSignin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      var response = await authRepository.signinWithUserandPass(
          username: event.username, password: event.password);

      if (response.containsKey('token')) {
        bool isAdmin = response['isAdmin'];
        log(isAdmin.toString(), name: "admin");
        emit(Authsuccess(
            authModel: AuthModel(
              isAdmin: isAdmin,
            ),
            isLoading: false));
      } else {
        log("invalid");
        emit(AuthError(errormsg: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(errormsg: e.toString()));
      log(e.toString());
    }
  }

  _signup(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      var response = await authRepository.signupWithUserandPass(
          email: event.email,
          username: event.username,
          password: event.password);

      if (response.containsKey('token')) {
        emit(AuthLoading());

        bool isAdmin = response['isAdmin'];
        log(isAdmin.toString(), name: "admin");
        emit(Authsuccess(
            authModel: AuthModel(isAdmin: isAdmin), isLoading: true));
      } else {
        log("invalid");
        emit(AuthError(errormsg: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(errormsg: e.toString()));
      log(e.toString());
    }
  }

  _listusers(ListUsers event, Emitter<AuthState> emit) async {
    final currentstate = state;
    try {
      if (currentstate is UsersListstate) {
        // emit(currentstate.copyWith(isLoading: true));
        final response = await authRepository.usersList();
        log('inside try of lisusers');
        emit(UsersListstate(users: response, isLoading: false));
      } else {
        emit(AuthLoading());
        final response = await authRepository.usersList();
        log('inside else of lisusers');

        emit(UsersListstate(users: response));
      }
    } catch (e) {
      log('inside error of list users');
      emit(UsersListError(e.toString()));
    }
  }

  _profileimageUpload(UploadProfile event, Emitter<AuthState> emit) async {
    try {
      var response = await authRepository.uploadprofileImage(
          profileImage: event.profileImage, id: event.userid);

      emit(Authupdated(imageUrl: response));
    } catch (e) {
      emit(AuthError(errormsg: e.toString()));
      log(e.toString());
    }
  }

  _deleteuser(Deleteuser event, Emitter<AuthState> emit) async {
    log('inside bloc');

    try {
      final currentstate = state;

      var response = await authRepository.deleteUser(userid: event.userId);
      if (currentstate is Authupdated) {
        try {
          log(response);
          emit(currentstate.copyWith(
              message: response, imageUrl: currentstate.imageUrl));
        } catch (e) {
          log(e.toString());
          currentstate.copyWith(errormessage: e.toString());
        }
      } else {
        emit(Authupdated(message: response));
      }
    } catch (e) {
      log(e.toString());
      AuthError(errormsg: e.toString());
    }
  }

  _resetpassword(Resetpassword event, Emitter<AuthState> emit) async {
    log('inside bloc');

    try {
      final currentstate = state;

      if (currentstate is Authupdated) {
        emit(currentstate.copyWith(isLoading: true, message: ''));

        var response =
            await authRepository.resetPassword(userName: event.userName);
        try {
          log(response);
          emit(currentstate.copyWith(
              isLoading: false,
              message: response,
              imageUrl: currentstate.imageUrl));
        } catch (e) {
          // log(e.toString());
          emit(currentstate.copyWith(
              errormessage: e.toString(), isLoading: false));
        }
      } else {
        log('inside bloc else');

        var response =
            await authRepository.resetPassword(userName: event.userName);
        // log(event.userName);
        //        log(response);
        emit(Authupdated(message: response, isLoading: false));
      }
    } catch (e) {
      log(e.toString());
      AuthError(errormsg: e.toString());
    }
  }

  _updateuser(Updateuser event, Emitter<AuthState> emit) async {
    final currentstate = state;
    if (currentstate is Authsuccess) {
      try {
        emit(currentstate.copywith(isLoading: true,message: ''),);
        var response = await authRepository.updateUser(
            userIdforupdate: event.userIdforupdate, authinfo: event.authModel);
        emit(currentstate.copywith(
          authModel: response['updatedinfo'],
          message: response['message'],
          isLoading: false,
        ));
      } catch (e) {
        currentstate.copywith(
            authModel: currentstate.authModel, errormessage: e.toString());
      }
    } else {
      try {
        var response = await authRepository.updateUser(
            userIdforupdate: event.userIdforupdate, authinfo: event.authModel);
        emit(Authsuccess(
          authModel: response['updatedinfo'],
          message: response['message']
        ));
      } catch (e) {
        emit(AuthError(errormsg: e.toString()));
      }
    }
  }
}

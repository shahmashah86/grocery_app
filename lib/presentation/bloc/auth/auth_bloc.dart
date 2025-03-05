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
  //user signin
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

//user signup
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

//users list
  _listusers(ListUsers event, Emitter<AuthState> emit) async {
    final currentstate = state;
    try {
      if (currentstate is UsersListstate) {
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

//profile image upload
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

  //delete user

  _deleteuser(Deleteuser event, Emitter<AuthState> emit) async {
    log('inside bloc');

    try {
      final currentstate = state;

      if (currentstate is Authupdated) {
        try {
          var response = await authRepository.deleteUser(userid: event.userId);
          log(response);
          emit(currentstate.copyWith(
              message: response,
              imageUrl: currentstate.imageUrl,
              errormessage: ''));
        } catch (e) {
          log(e.toString());
          currentstate.copyWith(
              message: '',
              imageUrl: currentstate.imageUrl,
              errormessage: e.toString());
        }
      } else {
        var response = await authRepository.deleteUser(userid: event.userId);
        emit(Authupdated(
          message: response,
        ));
      }
    } catch (e) {
      log(e.toString());
      AuthError(errormsg: e.toString());
    }
  }

//reset password
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
              isLoading: false,
              message: '',
              errormessage: e.toString(),
              imageUrl: currentstate.imageUrl));
        }
      } else {
        log('inside bloc else');

        var response =
            await authRepository.resetPassword(userName: event.userName);
        // log(event.userName);
        //        log(response);
        emit(Authupdated(
          isLoading: false,
          message: response,
        ));
      }
    } catch (e) {
      log(e.toString());
      AuthError(errormsg: e.toString());
    }
  }

//update user
  _updateuser(Updateuser event, Emitter<AuthState> emit) async {
    final currentstate = state;
    if (currentstate is Authsuccess) {
      try {
        emit(
          currentstate.copywith(isLoading: true, message: ''),
        );
        var response = await authRepository.updateUser(
            userIdforupdate: event.userIdforupdate, authinfo: event.authModel);
        emit(currentstate.copywith(
          authModel: response['updatedinfo'],
          isLoading: false,
          errormessage: '',
          message: response['message'],
        ));
      } catch (e) {
        currentstate.copywith(
            authModel: currentstate.authModel,
            isLoading: false,
            errormessage: e.toString());
      }
    } else {
      try {
        var response = await authRepository.updateUser(
            userIdforupdate: event.userIdforupdate, authinfo: event.authModel);
        emit(Authsuccess(
            isLoading: false,
            authModel: response['updatedinfo'],
            errormessage: '',
            message: response['message']));
      } catch (e) {
        emit(AuthError(errormsg: e.toString()));
      }
    }
  }
}

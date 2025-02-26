

import 'dart:io';

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';

abstract class AuthRepository {
  Future<Map<String,dynamic>> signinWithUserandPass({required String username, required String password});
Future<List<AuthModel>> usersList();
Future signupWithUserandPass({required email,required username,required password});
Future uploadprofileImage({File profileImage,int id});
Future deleteUser({required int userid});
Future resetPassword({required String userName});
Future updateUser({required int userIdforupdate,AuthModel authinfo});
}
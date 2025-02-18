

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';

abstract class AuthRepository {
  Future<Map<String,dynamic>> signinWithUserandPass({required String username, required String password});
Future<List<AuthModel>> usersList();
Future signupWithUserandPass({required name,required username,required password});
}
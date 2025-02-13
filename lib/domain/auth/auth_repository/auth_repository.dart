

import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';

abstract class AuthRepository {
  Future<Map<String,dynamic>> signinWithEmailandPass({required String username, required String password});
Future<List<AuthModel>> usersList();
}
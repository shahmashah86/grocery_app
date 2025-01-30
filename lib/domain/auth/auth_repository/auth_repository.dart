

abstract class AuthRepository {
  Future<Map<String,dynamic>> signinWithEmailandPass({required String username, required String password});

}
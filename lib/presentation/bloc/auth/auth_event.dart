// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignin extends AuthEvent{
  final String username;
  final String password;

  const AuthSignin({required this.username, required this.password});

}


class AuthSignUp extends AuthEvent {
  final String name;
    final String username;
  final String password;
  const AuthSignUp({
    required this.name,
    required this.username,
    required this.password,
  });
}
class AuthForgetPassword{
  final String email;

  AuthForgetPassword({required this.email});
}

class listUsers extends AuthEvent{}
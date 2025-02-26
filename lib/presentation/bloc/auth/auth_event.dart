// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignin extends AuthEvent {
  final String username;
  final String password;

  const AuthSignin({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String username;
  final String password;
  const AuthSignUp({
    required this.email,
    required this.username,
    required this.password,
  });
  @override
  List<Object> get props => [email, username, password];
}

class AuthForgetPassword {
  final String email;

  AuthForgetPassword({required this.email});

  List<Object> get props => [email];
}

class ListUsers extends AuthEvent {}

class UploadProfile extends AuthEvent {
  final int userid;
  final File profileImage;

  const UploadProfile({required this.userid, required this.profileImage});
  @override
  List<Object> get props => [userid, profileImage];
}

class Deleteuser extends AuthEvent {
  final int userId;

  const Deleteuser({required this.userId});
  @override
  List<Object> get props => [userId];
}

class Resetpassword extends AuthEvent {
  final String userName;

  const Resetpassword({required this.userName});
  @override
  List<Object> get props => [userName];
}
class Updateuser extends AuthEvent{

  final int userIdforupdate;
  final AuthModel authModel;

 const Updateuser(this.authModel, {required this.userIdforupdate});
 

}

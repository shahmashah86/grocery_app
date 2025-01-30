part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
class AuthLoading extends AuthState{}
final class Authsuccess extends AuthState{
final AuthModel authModel;
Authsuccess(
  {
  required this.authModel});

Authsuccess copywith({AuthModel? authModel}){
  return Authsuccess(authModel: authModel??this.authModel);
}
}

final class AuthError extends AuthState {

   
   final String? errormsg;

  const AuthError({this.errormsg});
    @override
  List<Object> get props => [errormsg!];

  AuthError copyWith({
   String? errormsg
  }) {
    return AuthError(errormsg: errormsg??this.errormsg);
  }


}

final class AuthSignOutSuccess extends AuthState {}
final class AuthSignOutError extends AuthState {}

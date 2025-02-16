part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
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
class AuthError extends AuthState {
  final String errormsg;
  final DateTime timestamp;

  AuthError({required this.errormsg, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now(); // Ensure it's never null

  @override
  List<Object> get props => [errormsg, timestamp];

  AuthError copyWith({String? errormsg, DateTime? timestamp}) {
    return AuthError(
      errormsg: errormsg ?? this.errormsg,
      timestamp: timestamp ?? DateTime.now(), // Ensure a fresh state is emitted everytime
    );
  }
}


final class AuthSignOutSuccess extends AuthState {}
final class AuthSignOutError extends AuthState {}
final class UsersListstate extends AuthState{

 final List<AuthModel>? users;
 final bool isLoading;

  const UsersListstate({this.isLoading=false, this.users});

    @override
  List<Object?> get props => [isLoading,users];

UsersListstate copyWith({bool? isLoading,List<AuthModel>? users}){
return UsersListstate(
  isLoading:isLoading??this.isLoading,
  users: users??this.users


);
}
}

final class UsersListError extends AuthState{
  final String errormsg;

  const UsersListError(this.errormsg);
    @override
  List<Object> get props => [errormsg];
}
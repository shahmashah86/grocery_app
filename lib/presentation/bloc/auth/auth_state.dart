part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

final class Authsuccess extends AuthState {
  final AuthModel authModel;
  final bool isLoading;
  final String errormessage;
  const Authsuccess(
      {this.isLoading = false, required this.authModel, this.errormessage = ''});

  Authsuccess copywith(
      {AuthModel? authModel, bool? isLoading, String? errormessage}) {
    return Authsuccess(
        authModel: authModel ?? this.authModel,
        errormessage: errormessage ?? this.errormessage,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [isLoading, authModel,errormessage];
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
      timestamp: timestamp ??
          DateTime.now(), // Ensure a fresh state is emitted everytime
    );
  }
}

final class AuthSignOutSuccess extends AuthState {}

final class AuthSignOutError extends AuthState {}

final class UsersListstate extends AuthState {
  final List<AuthModel>? users;
  final bool isLoading;

  const UsersListstate({this.isLoading = false, this.users});

  @override
  List<Object?> get props => [isLoading, users];

  UsersListstate copyWith({bool? isLoading, List<AuthModel>? users}) {
    return UsersListstate(
        isLoading: isLoading ?? this.isLoading, users: users ?? this.users);
  }
}

final class UsersListError extends AuthState {
  final String errormsg;

  const UsersListError(this.errormsg);
  @override
  List<Object> get props => [errormsg];
}

final class Authupdated extends AuthState {
  final String imageUrl;
  final String message;
  final bool isLoading;
  final String errormessage;

  const Authupdated(
      {this.imageUrl = '',
      this.message = '',
      this.errormessage = '',
      this.isLoading = false});

  Authupdated copyWith(
      {String? imageUrl,
      String? message,
      String? errormessage,
      bool? isLoading}) {
    return Authupdated(
      imageUrl:
          imageUrl ?? this.imageUrl, // Retains previous value if not provided
      message: message ?? this.message,
      errormessage: errormessage ?? this.errormessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [imageUrl, message, errormessage, isLoading];
}

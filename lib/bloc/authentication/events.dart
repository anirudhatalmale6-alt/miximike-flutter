part of 'bloc.dart';

abstract class AuthenticationEvents {}

class SignInEvent extends AuthenticationEvents {
  final String email;
  final String password;
  final bool rememberMe;
  final void Function()? beforeSuccess;
  final void Function()? afterSuccess;
  final void Function(DioException e)? afterError;

  SignInEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
    this.beforeSuccess,
    this.afterSuccess,
    this.afterError,
  });
}

class SignUpEvent extends AuthenticationEvents {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final void Function()? beforeSuccess;
  final void Function()? afterSuccess;
  final void Function(DioException e)? afterError;

  SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.beforeSuccess,
    this.afterSuccess,
    this.afterError,
  });
}

class LogOutEvent extends AuthenticationEvents {
  final void Function()? afterSuccess;

  LogOutEvent({
    this.afterSuccess,
  });
}

class SetUserEvent extends AuthenticationEvents {
  final User user;

  SetUserEvent({
    required this.user,
  });
}

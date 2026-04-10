part of 'bloc.dart';

class AuthenticationState extends Equatable {
  final bool logInIsLoading;
  final bool logUpIsLoading;
  final bool isLogged;
  final User user;

  const AuthenticationState({
    this.logInIsLoading = false,
    this.logUpIsLoading = false,
    this.isLogged = false,
    required this.user,
  });

  @override
  List<Object?> get props => [
    logInIsLoading,
    logUpIsLoading,
    isLogged,
    user.id,
  ];

  AuthenticationState copyWith({
    bool? logInIsLoading,
    bool? logUpIsLoading,
    bool? isLogged,
    User? user,
  }) {
    return AuthenticationState(
      logInIsLoading: logInIsLoading ?? this.logInIsLoading,
      logUpIsLoading: logUpIsLoading ?? this.logUpIsLoading,
      isLogged: isLogged ?? this.isLogged,
      user: user ?? this.user,
    );
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/api/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/client.dart';
import '../../utils/local_storage.dart';

part 'events.dart';
part 'state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvents, AuthenticationState> {
  AuthenticationBloc({required AuthenticationState initialState}) : super(initialState) {
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<LogOutEvent>(_logOut);
    on<SetUserEvent>(_setUser);
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(logInIsLoading: true));
    String token = base64Encode(utf8.encode('${event.email}:${event.password}'));

    await AuthenticationClient.signIn(
      token: token,
    ).then((response) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt(LocalStorage.userId, response.data['id']);
      localStorage.setString(LocalStorage.authorization, token);
      localStorage.setString(LocalStorage.email, event.email);
      localStorage.setBool(LocalStorage.rememberMe, event.rememberMe);
      event.afterSuccess?.call();

      emit(
          state.copyWith(
            logInIsLoading: false,
            isLogged: true,
            user: User.fromJson({
              ...response.data,
              'username': event.email,
            }),
          )
      );
    }).onError<DioException>((error, stackTrace) {
      emit(
          state.copyWith(
              logInIsLoading: false,
              isLogged: false
          )
      );
      event.afterError?.call(error);
    });
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        logUpIsLoading: true
    ));

    await AuthenticationClient.signUp(
      username: event.username,
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
    ).then((response) async {
      emit(
          state.copyWith(
            logUpIsLoading: false,
            isLogged: false,
          )
      );
      event.afterSuccess?.call();
    }).onError<DioException>((error, stackTrace) {
      emit(
          state.copyWith(
              logUpIsLoading: false,
              isLogged: false
          )
      );
      event.afterError?.call(error);
    });
  }

  void _logOut(LogOutEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(isLogged: false));

    SharedPreferences.getInstance().then((localStorage) {
      localStorage.remove(LocalStorage.userId);
      localStorage.remove(LocalStorage.authorization);
      localStorage.remove(LocalStorage.email);
      localStorage.remove(LocalStorage.lastDateTimeNotificationViewed);
    });

    event.afterSuccess?.call();
  }

  void _setUser(SetUserEvent event, Emitter<AuthenticationState> emit) => emit(
      state.copyWith(
          user: event.user,
          isLogged: event.user.id != 0
      )
  );
}

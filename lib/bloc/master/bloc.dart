import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/client.dart';
import '../../api/models/user.dart';
import '../../utils/local_storage.dart';

part 'events.dart';
part 'state.dart';

class MasterBloc extends Bloc<MasterEvents, MasterState> {
  MasterBloc({
    MasterState initialState = const MasterState(),
  }) : super(initialState) {
    on<InitAppEvent>(_isLoading);
  }

  Future<void> _isLoading(InitAppEvent event, Emitter<MasterState> emit) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await dotenv.load(fileName: '.env');
    User user = await _getUser(localStorage);

    event.afterSuccess?.call(user);

    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.miximyke.background.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );

    emit(
        state.copyWith(
          isLoading: false,
          localStorage: localStorage,
        )
    );
  }

  Future<User> _getUser(SharedPreferences localStorage) async {
    int? userId = localStorage.getInt(LocalStorage.userId);
    String? token = localStorage.getString(LocalStorage.authorization);
    String? email = localStorage.getString(LocalStorage.email);
    bool? rememberMe = localStorage.getBool(LocalStorage.rememberMe) ?? false;

    if (rememberMe && userId != null && token != null && email != null) {
      return await AuthenticationClient.signIn(
        token: token,
      ).then((response) => User.fromJson({
        ...response.data,
        'username': email,
      })).onError((error, stackTrace) => User(id: 0, username: '', name: ''));
    }

    return User(id: 0, username: '', name: '');
  }
}

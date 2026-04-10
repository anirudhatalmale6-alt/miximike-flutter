import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/utils/local_storage.dart';
import 'package:flutter_music/utils/random_int.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/models/product.dart';
import '../../api/models/track.dart';

part 'events.dart';
part 'state.dart';

class PlayerBloc extends Bloc<PlayerEvents, PlayerState> {
  PlayerBloc({required PlayerState initialState}) : super(initialState) {
    on<InitPlayerEvent>(_initPlayer);
    on<OnDragPlayerEvent>(_onDragPlayer);
    on<SetIsDragging>(_setIsDragging);
    on<ResetPlayerEvent>(_resetPlayer);
  }

  Future<void> _initPlayer(InitPlayerEvent event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(isLoading: true));

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
        children: event.tracks.map((track) => track.isLocal  ? AudioSource.asset(
          track.url,
          tag: MediaItem(
            id: track.id,
            album: track.product.name,
            title: track.name,
            artUri: Uri.parse(track.imageUrl),
          ),
        ) : AudioSource.uri(
          Uri.parse(track.url),
          headers:  {
            'Authorization': 'Basic ${localStorage.getString(LocalStorage.authorization)}'
          },
          tag: MediaItem(
            id: track.id,
            album: track.product.name,
            title: track.name,
            artUri: Uri.parse(track.imageUrl),
          ),
        )).toList()
    );

    state.player..setAudioSource(
      playlist,
      initialIndex: event.shuffle ? RandomInt.generate(min: 0, max: event.tracks.length - 1): event.initialIndex,
      initialPosition: Duration.zero,
    )..setShuffleModeEnabled(event.shuffle)..play();

    emit(
        state.copyWith(
          isLoading: false,
          isDragging: false,
          playList: playlist,
          tracks: event.tracks,
        )
    );
  }

  void _onDragPlayer(OnDragPlayerEvent event, Emitter<PlayerState> emit) {
    emit(
        state.copyWith(
          isDragging: true,
          newDraggingPosition: event.seconds,
        )
    );
  }

  void _setIsDragging(SetIsDragging event, Emitter<PlayerState> emit) {
    emit(
        state.copyWith(
          isDragging: event.isDragging,
        )
    );
  }

  void _resetPlayer(ResetPlayerEvent event, Emitter<PlayerState> emit) {
    state.player.stop();
    state.player.dispose();

    AudioPlayer player = AudioPlayer();

    emit(
        state.copyWith(
          isLoading: false,
          isDragging: false,
          player: player,
          positionStream: player.createPositionStream(
              steps: 1000
          ),
          playList: ConcatenatingAudioSource(
              children: []
          ),
        )
    );
  }
}

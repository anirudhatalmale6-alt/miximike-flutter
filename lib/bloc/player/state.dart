part of 'bloc.dart';

class PlayerState extends Equatable {
  final bool isLoading;
  final AudioPlayer player;
  final ConcatenatingAudioSource playList;
  final Stream<Duration> positionStream;
  final List<Track> tracks;
  final Product? album;

  final int newDraggingPosition;
  final bool isDragging;

  const PlayerState({
    this.isLoading = false,
    required this.player,
    required this.playList,
    this.positionStream = const Stream.empty(),
    this.tracks = const [],
    this.album,
    this.newDraggingPosition = 0,
    this.isDragging = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    player.currentIndex,
    player,
    playList,
    newDraggingPosition,
    isDragging,
  ];

  PlayerState copyWith({
    bool? isLoading,
    AudioPlayer? player,
    ConcatenatingAudioSource? playList,
    Stream<Duration>? positionStream,
    List<Track>? tracks,
    Product? album,
    int? newDraggingPosition,
    bool? isDragging,
  }) {
    return PlayerState(
      isLoading: isLoading ?? this.isLoading,
      player: player ?? this.player,
      playList: playList ?? this.playList,
      positionStream: positionStream ?? this.positionStream,
      tracks: tracks ?? this.tracks,
      album: album ?? this.album,
      newDraggingPosition: newDraggingPosition ?? this.newDraggingPosition,
      isDragging: isDragging ?? this.isDragging,
    );
  }

  double getCurrentTrackPositionPercent(int currentPosition)  {
    // if (!player.playing) return 0;
    if (player.duration == null) return 0;

    return double.parse(
        (currentPosition != 0 ? (currentPosition / player.duration!.inSeconds ) : 0).toStringAsFixed(2)
    );
  }
}

part of 'bloc.dart';

abstract class PlayerEvents {}

class InitPlayerEvent extends PlayerEvents {
  final List<Track> tracks;
  final int initialIndex;
  final bool shuffle;

  InitPlayerEvent({
    required this.tracks,
    this.initialIndex = 0,
    this.shuffle = false,
  });
}

class OnDragPlayerEvent extends PlayerEvents {
  final int seconds;

  OnDragPlayerEvent({
    required this.seconds,
  });
}

class SetIsDragging extends PlayerEvents {
  final bool isDragging;

  SetIsDragging({
    required this.isDragging
  });
}

class ResetPlayerEvent extends PlayerEvents {}
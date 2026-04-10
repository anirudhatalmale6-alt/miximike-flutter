import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/screens/home/widgets/playlist.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

import '../../../api/models/track.dart';
import '../../../bloc/player/bloc.dart';
import '../../../utils/theme.dart';

class TrackDetailsScreen extends StatefulWidget {
  const TrackDetailsScreen({super.key});

  @override
  State<TrackDetailsScreen> createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  late List<Track> tracks = Get.arguments['tracks'];
  final int initialIndex = Get.arguments['index'] ?? 0;
  final bool shuffle = Get.arguments['shuffle'] ?? false;
  final bool reloadPlaylist = Get.arguments['reloadPlaylist'] ?? true;
  final horizontalPadding = 15.0;

  late PlayerBloc playerBloc = context.read<PlayerBloc>();

  @override
  void initState() {
    super.initState();
    if (reloadPlaylist) {
      playerBloc.add(InitPlayerEvent(
        tracks: tracks,
        initialIndex: initialIndex,
        shuffle: shuffle,
      ));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerBloc = context.read<PlayerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
        buildWhen: (previous, current) =>
        previous.isLoading != current.isLoading,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
              title: StreamBuilder<int?>(
                  stream: playerBloc.state.player.currentIndexStream,
                  initialData: 0,
                  builder: (context, snapshot) {
                    return Text(tracks[snapshot.data ?? 0].product.name);
                  }),
              backgroundColor: AppTheme.lightThreeColor,
            ),
            backgroundColor: AppTheme.lightThreeColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: LayoutBuilder(
                builder: (context, constraint) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraint.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: StreamBuilder<int?>(
                                stream:
                                playerBloc.state.player.currentIndexStream,
                                initialData: 0,
                                builder: (context, snapshot) {
                                  return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: tracks[snapshot.data ?? 0].imageUrl,
                                    width: MediaQuery.of(context).size.width,
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<int?>(
                              stream:
                              playerBloc.state.player.currentIndexStream,
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  tracks[snapshot.data ?? 0].name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'Vogue Bold'),
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<int?>(
                              stream:
                              playerBloc.state.player.currentIndexStream,
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  tracks[snapshot.data ?? 0].product.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamBuilder<just_audio.LoopMode>(
                                      stream: state.player.loopModeStream,
                                      builder: (context, snapshot) {
                                        final currentLoopMode = snapshot.data;
                                        final newLoopMode = currentLoopMode == just_audio.LoopMode.all ? just_audio.LoopMode.off : just_audio.LoopMode.all;

                                        return IconButton(
                                          icon: Semantics(
                                            label: 'Reproducción sin fin',
                                            button: true,
                                            excludeSemantics: true,
                                            child: Icon(
                                              Icons.repeat,
                                              size: 30,
                                              color: currentLoopMode == just_audio.LoopMode.off ? Colors.white : AppTheme.lightFiveColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            playerBloc.state.player.setLoopMode(newLoopMode);
                                          },
                                        );
                                      }
                                  ),
                                  IconButton(
                                    icon: Semantics(
                                      label: 'Lista de reproducción',
                                      button: true,
                                      excludeSemantics: true,
                                      child: const Icon(
                                        Icons.list,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) =>
                                        const FractionallySizedBox(
                                            heightFactor: 0.85,
                                            child: PlayListModal()
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              ExcludeSemantics(
                                child: Listener(
                                  behavior: HitTestBehavior.opaque,
                                  onPointerUp: (PointerUpEvent details) {
                                    num maxWidth = constraint.maxWidth;
                                    num currentPointer =
                                        details.position.dx - horizontalPadding;
                                    int seconds = (currentPointer *
                                        state.player.duration!.inSeconds /
                                        maxWidth)
                                        .round();

                                    if (seconds < 0) {
                                      seconds = 0;
                                    } else if (seconds >
                                        state.player.duration!.inSeconds) {
                                      seconds = state.player.duration!.inSeconds;
                                    }

                                    playerBloc.add(OnDragPlayerEvent(
                                      seconds: seconds,
                                    ));
                                    playerBloc.add(SetIsDragging(
                                      isDragging: false,
                                    ));
                                    state.player.seek(Duration(seconds: seconds));
                                  },
                                  child: BlocBuilder<PlayerBloc, PlayerState>(
                                    buildWhen: (previous, current) =>
                                    previous.newDraggingPosition !=
                                        current.newDraggingPosition ||
                                        previous.isDragging != current.isDragging,
                                    builder: (context, state) {
                                      return StreamBuilder<Duration>(
                                          stream: playerBloc.state.positionStream,
                                          initialData: Duration.zero,
                                          builder: (context, snapshot) {
                                            double currentTrackPositionPercent =
                                            state.getCurrentTrackPositionPercent(
                                                state.isDragging
                                                    ? state.newDraggingPosition
                                                    : playerBloc.state.player.position.inSeconds
                                              // : snapshot.data?.inSeconds ?? 0
                                            );

                                            return SizedBox(
                                              height: 50,
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 21),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      child:
                                                      LinearProgressIndicator(
                                                        value:
                                                        currentTrackPositionPercent,
                                                        backgroundColor:
                                                        Colors.grey[400],
                                                        color: Colors.white,
                                                        minHeight: 7.5,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      left: (constraint.maxWidth -
                                                          horizontalPadding) *
                                                          currentTrackPositionPercent,
                                                      child: Draggable(
                                                        axis: Axis.horizontal,
                                                        feedback: const SizedBox(
                                                          height: 50,
                                                          width: 20,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                            Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        child: const SizedBox(
                                                          height: 50,
                                                          width: 20,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        onDragUpdate: (details) {
                                                          num maxWidth =
                                                              constraint.maxWidth;
                                                          num currentPointer =
                                                              details.localPosition
                                                                  .dx -
                                                                  horizontalPadding;

                                                          int seconds =
                                                          (currentPointer *
                                                              state
                                                                  .player
                                                                  .duration!
                                                                  .inSeconds /
                                                              maxWidth)
                                                              .round();

                                                          if (seconds < 0) {
                                                            seconds = 0;
                                                          } else if (seconds >
                                                              state
                                                                  .player
                                                                  .duration!
                                                                  .inSeconds) {
                                                            seconds = state
                                                                .player
                                                                .duration!
                                                                .inSeconds;
                                                          }

                                                          playerBloc.add(
                                                              OnDragPlayerEvent(
                                                                seconds: seconds,
                                                              ));
                                                        },
                                                        onDragEnd: (details) {
                                                          playerBloc
                                                              .add(SetIsDragging(
                                                            isDragging: false,
                                                          ));
                                                        },
                                                      )),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Semantics(
                                    label: 'Tiempos de reproducción',
                                    child: StreamBuilder<Duration>(
                                        stream: playerBloc.state.positionStream,
                                        initialData: Duration.zero,
                                        builder: (context, snapshot) {
                                          Duration position = playerBloc.state.player.position;

                                          return Text(
                                              "${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ));
                                        }),
                                  ),
                                  Semantics(
                                    label: 'Duración de la canción',
                                    child: StreamBuilder<just_audio.PlaybackEvent>(
                                        stream: state.player.playbackEventStream,
                                        initialData: state.player.playbackEvent,
                                        builder: (context, snapshot) {
                                          String duration = "00:00";

                                          if (snapshot.data?.currentIndex !=
                                              null &&
                                              state.player.duration != null) {
                                            duration =
                                            "${state.player.duration?.inMinutes}:${state.player.duration?.inSeconds.remainder(60).toString().padLeft(2, '0')}";
                                          }
                                          return Text(duration,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ));
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Semantics(
                                        label: 'Retroceder a la canción anterior',
                                        excludeSemantics: true,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.skip_previous,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              state.player.seekToPrevious(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Semantics(
                                        label: 'Retroceder 10 segundos',
                                        excludeSemantics: true,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.replay_10,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () => state.player.seek(
                                              Duration(
                                                  seconds: state.player.position
                                                      .inSeconds -
                                                      10)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: StreamBuilder<bool>(
                                          stream: state.player.playingStream,
                                          initialData: false,
                                          builder: (context, snapshot) {
                                            if (snapshot.data!) {
                                              return Semantics(
                                                label: 'Pausar la canción',
                                                excludeSemantics: true,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.pause_circle,
                                                    size: 80,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      state.player.pause(),
                                                ),
                                              );
                                            }

                                            return Semantics(
                                              label: 'Reproducir la canción',
                                              excludeSemantics: true,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.play_circle,
                                                  size: 80,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () =>
                                                    state.player.play(),
                                              ),
                                            );
                                          }),
                                    ),
                                    Expanded(
                                      child: Semantics(
                                        label: 'Avanzar 10 segundos',
                                        excludeSemantics: true,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.forward_10_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () => state.player.seek(
                                              Duration(
                                                  seconds: state.player.position
                                                      .inSeconds +
                                                      10)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Semantics(
                                        label: 'Avanzar a la siguiente canción',
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.skip_next,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              state.player.seekToNext(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

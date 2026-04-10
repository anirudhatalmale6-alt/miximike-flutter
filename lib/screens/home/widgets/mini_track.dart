import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

import '../../../bloc/player/bloc.dart';
import '../../../utils/routes.dart';

class MiniTrack extends StatelessWidget {
  const MiniTrack({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerBloc playerBloc = context.read<PlayerBloc>();

    return StreamBuilder<just_audio.PlaybackEvent>(
        stream: playerBloc.state.player.playbackEventStream,
        initialData: playerBloc.state.player.playbackEvent,
        builder: (context, snapshot) {
          bool haveTrack = snapshot.data?.currentIndex != null;
          if (!haveTrack) return Container();

          return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5
            ),
            color: AppTheme.lightSecondaryColor,
            child: Column(
              children: [
                BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) {
                      return StreamBuilder<int?>(
                          stream: state.player.currentIndexStream,
                          initialData: 0,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () => Get.toNamed(
                                Routes.trackDetails,
                                arguments: {
                                  'tracks': state.tracks,
                                  'index': snapshot.data ?? 0,
                                  'reloadPlaylist': false,
                                },
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        // add border
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.white
                                        ),
                                        // set border radius
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),

                                        child: StreamBuilder<int?>(
                                            stream: playerBloc.state.player.currentIndexStream,
                                            initialData: 0,
                                            builder: (context, snapshot) {
                                              return CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: state.tracks[snapshot.data ?? 0].imageUrl,
                                                width: MediaQuery.of(context).size.width,
                                              );
                                            }
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 10
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.tracks[snapshot.data ?? 0].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
                                                fontFamily: 'Vogue Bold',
                                                color: Colors.white
                                            ),
                                          ),
                                          Text(
                                            state.tracks[snapshot.data ?? 0].product.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    StreamBuilder<bool>(
                                        stream: playerBloc.state.player.playingStream,
                                        initialData: false,
                                        builder: (context, snapshot) {
                                          if (snapshot.data!) {
                                            return IconButton(
                                              icon: const Icon(
                                                Icons.pause_circle,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                              onPressed: () => playerBloc.state.player.pause(),
                                            );
                                          }
                                          return IconButton(
                                            icon: const Icon(
                                              Icons.play_circle,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            onPressed: () => playerBloc.state.player.play(),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
                const SizedBox(
                  height: 5,
                ),
                StreamBuilder<Duration>(
                    stream: playerBloc.state.positionStream,
                    initialData: Duration.zero,
                    builder: (context, snapshot) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: playerBloc.state.getCurrentTrackPositionPercent(snapshot.data!.inSeconds),
                          backgroundColor: Colors.grey[400],
                          color: Colors.white,
                          minHeight: 4,
                        ),
                      );
                    }
                )
              ],
            ),
          );
        }
    );
  }
}

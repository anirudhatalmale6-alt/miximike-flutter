import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/player/bloc.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';

class Track extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String subTitle;
  final bool withIsPlaying;
  final bool isLocal;
  final Function() onTap;

  const Track({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.withIsPlaying = true,
    this.isLocal = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final PlayerBloc playerBloc = context.read<PlayerBloc>();
    final AudioPlayer player = playerBloc.state.player;

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: imageUrl,
              height: isLocal ? 80 : 60,
              width: 80,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[350]!,
                child: Container(
                  height: isLocal ? 80 : 60,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Vogue Bold'
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontFamily: 'Vogue Bold'
                  ),
                ),
              ],
            ),
          ),
          withIsPlaying ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: StreamBuilder<int?>(
                stream: playerBloc.state.player.currentIndexStream,
                initialData: 0,
                builder: (context, snapshot) {
                  String currentId = player.sequence?[snapshot.data ?? 0].tag.id ?? '';

                  return currentId != '' && currentId == id ? const SpinKitWave(
                    size: 30,
                    color: AppTheme.lightPrimaryColor,
                    type: SpinKitWaveType.center,
                  ) : Icon(
                    Icons.play_circle,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  );
                }
            ),
          ) : Icon(
            Icons.play_circle,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

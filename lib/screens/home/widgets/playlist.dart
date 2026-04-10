import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/player/bloc.dart';
import 'package:flutter_music/widgets/tracks/track.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayListModal extends StatelessWidget {
  const PlayListModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PlayerBloc playerBloc = context.read<PlayerBloc>();
    final AudioPlayer player = playerBloc.state.player;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Canciones",
                    style: TextStyle(
                      fontFamily: 'Vogue Bold',
                      fontSize: 18,
                    ),
                  ),
                  Semantics(
                    label: 'Cantidad de canciones',
                    child: Text(
                      player.sequence!.length.toString(),
                      style: const TextStyle(
                        fontFamily: 'Vogue Bold',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: player.sequence!.length,
                  itemBuilder: (context, index) {
                    int trackIndex = player.shuffleModeEnabled
                        ? player.shuffleIndices?.indexOf(index) ?? 0
                        : index;

                    return Track(
                      id: player.sequence?[trackIndex].tag.id ?? '',
                      imageUrl: player.sequence?[trackIndex].tag.artUri.toString() ?? '',
                      title: player.sequence?[trackIndex].tag.title ?? '',
                      subTitle: player.sequence?[trackIndex].tag.album ?? '',
                      onTap: () {
                        Get.back();
                        player.seek(Duration.zero, index: trackIndex);
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

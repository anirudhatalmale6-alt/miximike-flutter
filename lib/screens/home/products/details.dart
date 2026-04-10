import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_music/api/models/artist.dart';
import 'package:flutter_music/api/models/product.dart';
import 'package:flutter_music/api/models/track.dart' as track_model;
import 'package:flutter_music/bloc/product/bloc.dart';
import 'package:flutter_music/utils/routes.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_music/widgets/tracks/track.dart';
import 'package:get/get.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.products
  });

  final String title;
  final Artist artist;
  final List<Product> products;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final int diskForAllId = int.parse(dotenv.env['DISK_FOR_ALL_ID'] as String);
  late final String title = widget.title;
  late final Artist artist = widget.artist;
  late final List<Product> products = widget.products;

  final scrollController = ScrollController();

  late List<track_model.Track> tracks = products
      .map((e) => e.tracks)
      .expand((element) => element)
      .toList()..sort((a, b) => a.product.order.date.compareTo(b.product.order.date));

  late ProductBloc productBloc = context.read<ProductBloc>();

  void backAction() {
    if (artist.isOnlyDiskForAll) {
      productBloc.add(SetSingleArtistEvent(artist: null));
      return;
    }

    productBloc.add(SetSingleProductsEvent(products: []));
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      animate: true,
      duration: const Duration(seconds: 1),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult : (didPop, result) {
          if (didPop) {
            return;
          }
          backAction();
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => backAction(),
              )
          ),
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.lightFourColor,
                  Colors.white,
                  Colors.white,
                  AppTheme.lightFourColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.1, 0.9, 1],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Column(
                  //   children: [
                  //     CachedNetworkImage(
                  //       fit: BoxFit.cover,
                  //       // imageUrl: 'products.imageUrl',
                  //       imageUrl: 'products.imageUrl',
                  //       width: double.infinity,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    artist.realName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Vogue Bold',
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () => Get.toNamed(
                                      Routes.trackDetails,
                                      arguments: {
                                        'tracks': tracks,
                                      }
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                          Icons.play_circle,
                                          size: 20,
                                          color: Colors.white
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Reproducir",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Vogue Bold',
                                            color: Colors.white
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () => Get.toNamed(
                                      Routes.trackDetails,
                                      arguments: {
                                        'tracks': tracks,
                                        'shuffle': true
                                      }
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                          Icons.shuffle,
                                          size: 20,
                                          color: Colors.white
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Aleatorio",
                                        style: TextStyle(
                                          fontFamily: 'Vogue Bold',
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Vogue Bold'
                              ),
                            ),
                            Text(
                              "${tracks.length}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Vogue Bold'
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(),
                        ),
                        LiveGrid(
                          itemCount: tracks.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: scrollController,
                          showItemInterval: const Duration(
                            milliseconds: 100,
                          ),
                          showItemDuration: const Duration(milliseconds: 150),
                          reAnimateOnVisibility: false,

                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 75,
                            // childAspectRatio: 2.0,
                          ),
                          itemBuilder: (context, index, animation) {
                            return FadeTransition(
                              opacity: Tween<double>(
                                begin: 0,
                                end: 1,
                              ).animate(animation),
                              child: Track(
                                id: tracks[index].id,
                                imageUrl: tracks[index].imageUrl,
                                // imageUrl: products.imageUrl,
                                title: tracks[index].name,
                                // subTitle: "3:21",
                                // subTitle: 'products.name',
                                subTitle: tracks[index].product.name,
                                onTap: () => Get.toNamed(
                                    Routes.trackDetails,
                                    arguments: {
                                      'tracks': tracks,
                                      'index': index
                                    }
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

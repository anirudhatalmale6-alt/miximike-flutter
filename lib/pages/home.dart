import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/notification/bloc.dart';
import 'package:flutter_music/bloc/product/bloc.dart';

import '../bloc/player/bloc.dart';
import '../screens/home/artists/artists.dart';
import '../screens/home/tracks/tracks.dart';
import '../screens/home/widgets/mini_track.dart';
import '../utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final int currentIndex = 0;

  late PlayerBloc playerBloc = context.read<PlayerBloc>();
  late final ProductBloc productBloc = context.read<ProductBloc>();
  late NotificationBloc notificationBloc = context.read<NotificationBloc>();
  late final TabController _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this
  )..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    productBloc.add(InitProductEvent(forceReload: true));
    notificationBloc.add(InitNotificationEvent(forceReload: true));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerBloc = context.read<PlayerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showModalBottomSheet(
      //       context: context,
      //       isScrollControlled: true,
      //       builder: (BuildContext context) => const FractionallySizedBox(
      //           heightFactor: 0.85,
      //           child: SearchModal()
      //       )
      //   ),
      //   backgroundColor: AppTheme.lightSecondaryColor,
      //   child: const Icon(
      //     Icons.search,
      //     color: Colors.white,
      //   ),
      // ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniTrack(),
          Container(
            height: 60,
            color: AppTheme.lightPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            _tabController.animateTo(0);
                            productBloc.add(SetSingleProductsEvent(products: []));

                            if (state.singleArtist != null) {
                              productBloc.add(SetSingleArtistEvent(artist: state.singleArtist));

                              return;
                            }

                            productBloc.add(SetSingleArtistEvent(artist: null));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: _tabController.index == 0 ? AppTheme.lightSecondaryColor : AppTheme.lightPrimaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10
                            ),
                            child: const AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.sort_by_alpha,
                                  //   size: 30,
                                  //   color: Colors.white,
                                  // ),
                                  Text(
                                    'NOMBRES',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontFamily: 'Vogue Bold',
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                  // const Spacer(),
                  // InkWell(
                  //   onTap: () => _tabController.animateTo(1),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(32),
                  //       color: _tabController.index == 1 ? AppTheme.lightSecondaryColor : AppTheme.lightPrimaryColor,
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 5,
                  //         horizontal: 10
                  //     ),
                  //     child: AnimatedSize(
                  //       duration: const Duration(milliseconds: 300),
                  //       alignment: Alignment.centerLeft,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           const Icon(
                  //             Icons.album,
                  //             color: Colors.white,
                  //             size: 30,
                  //           ),
                  //           if (_tabController.index == 1) Text(
                  //             titles[(_tabController.index)]!,
                  //             overflow: TextOverflow.ellipsis,
                  //             maxLines: 1,
                  //             softWrap: false,
                  //             style: const TextStyle(
                  //                 fontFamily: 'Vogue Bold',
                  //                 color: Colors.white
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            _tabController.animateTo(1);
                            productBloc.add(SetSingleProductsEvent(products: []));

                            if (state.singleArtist != null) {
                              productBloc.add(SetSingleArtistEvent(artist: state.singleArtist));

                              return;
                            }

                            productBloc.add(SetSingleArtistEvent(artist: null));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: _tabController.index == 1 ? AppTheme.lightSecondaryColor : AppTheme.lightPrimaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10
                            ),
                            child: const AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    'Todo el contenido',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontFamily: 'Vogue Bold',
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ArtistsScreen(),
          // ProductsScreen(),
          TrackScreen(),
        ],
      ),
    );
  }
}

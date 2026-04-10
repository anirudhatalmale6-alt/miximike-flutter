import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/widgets/tracks/track.dart';
import 'package:get/get.dart';

import '../../../api/models/product.dart';
import '../../../bloc/product/bloc.dart';
import '../../../utils/routes.dart';
import '../../../utils/theme.dart';
import '../../../widgets/list/advanced_list.dart';
import '../../../widgets/tracks/track_skeleton.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen>
    with SingleTickerProviderStateMixin {
  late ProductBloc productBloc = context.read<ProductBloc>();
  final scrollController = ScrollController();

  late AnimationController colorController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation enableColor = ColorTween(begin: AppTheme.lightPrimaryColor, end: Colors.grey)
      .animate(colorController);
  late Animation disableColor = ColorTween(begin: Colors.grey, end: AppTheme.lightPrimaryColor)
      .animate(colorController);


  @override
  void initState() {
    super.initState();
    productBloc.add(SearchEvents(
      searchTypeTracks: ProductType.mix,
    ));
  }

  @override
  void dispose() {
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          productBloc.add(InitProductEvent(forceReload: true));
          await productBloc.stream.firstWhere((state) => !state.isLoading);
        },
        child: AdvancedList(
          title: const Text("Canciones"),
          searchField: BlocBuilder<ProductBloc, ProductState>(
              buildWhen: (previous, current) =>
              (previous.isLoading != current.isLoading),
              builder: (context, state) {
                return FormBuilderTextField(
                  name: 'search',
                  enabled: !state.isLoading,
                  controller: TextEditingController(
                    text: state.searchTracks,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Buscar canción',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.lightThreeColor,
                    ),
                  ),
                  onSubmitted: (value) {
                    productBloc.add(SearchEvents(
                      searchTracks: value!,
                      searchTypeTracks: state.searchTypeTracks,
                    ));
                  },
                );
              }),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  double withButton = constraints.maxWidth / 2 - 20;

                  return BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading ||
                          previous.searchTypeTracks != current.searchTypeTracks,
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: withButton,
                                  child: ElevatedButton(
                                    onPressed: !state.isLoading
                                        ? () {
                                      productBloc.add(SearchEvents(
                                        searchTypeTracks:
                                        ProductType.disk,
                                      ));
                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state.searchTypeTracks == ProductType.disk ? AppTheme.lightPrimaryColor : Colors.grey,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Canciones personalizadas",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Vogue Bold'
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 55,
                                  width: withButton,
                                  child: ElevatedButton(
                                    onPressed: !state.isLoading
                                        ? () {
                                      productBloc.add(SearchEvents(
                                        searchTypeTracks:
                                        ProductType.audioBook,
                                      ));


                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state.searchTypeTracks == ProductType.audioBook ? AppTheme.lightPrimaryColor : Colors.grey,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Cuentos personalizados",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Vogue Bold'
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: withButton,
                                  child: ElevatedButton(
                                    onPressed: !state.isLoading
                                        ? () {
                                      productBloc.add(SearchEvents(
                                        searchTypeTracks:
                                        ProductType.diskForAll,
                                      ));

                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state.searchTypeTracks == ProductType.diskForAll ? AppTheme.lightPrimaryColor : Colors.grey,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Canciones para todos",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Vogue Bold'
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 55,
                                  width: withButton,
                                  child: ElevatedButton(
                                    onPressed: !state.isLoading
                                        ? () {
                                      productBloc.add(
                                          SearchEvents(
                                            searchTypeTracks: ProductType.mix,
                                          )
                                      );
                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state.searchTypeTracks == ProductType.mix ? AppTheme.lightPrimaryColor : Colors.grey,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Mix todas las canciones",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Vogue Bold'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: BlocBuilder<ProductBloc, ProductState>(
                                  buildWhen: (previous, current) =>
                                  previous.isLoading != current.isLoading,
                                  builder: (context, state) {
                                    return AnimatedBuilder(
                                        animation: enableColor,
                                        builder: (context, child) {
                                          return ElevatedButton(
                                            onPressed: !state.isLoading &&
                                                state.tracksFilters
                                                    .isNotEmpty
                                                ? () => Get.toNamed(
                                                Routes.trackDetails,
                                                arguments: {
                                                  'tracks': state
                                                      .tracksFilters,
                                                  'shuffle': true
                                                })
                                                : null,
                                            child: const Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.shuffle,
                                                    size: 20,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Reproducir aleatoriamente",
                                                  style: TextStyle(
                                                    fontFamily: 'Vogue Bold',
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ],
                        );
                      });
                }),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Canciones",
                        style:
                        TextStyle(fontSize: 18, fontFamily: 'Vogue Bold'),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                          buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                          builder: (context, state) {
                            return Text(
                              state.isLoading
                                  ? ""
                                  : "${state.tracksFilters.length}",
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Vogue Bold'),
                            );
                          })
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
                buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (!state.isLoading && state.tracksFilters.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: FadeInUp(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Center(
                            child: Text(
                                'No se han encontrado resultados en base a tus parámetros de búsqueda.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    );
                  }

                  return LiveSliverGrid(
                      key: ValueKey(
                          "albums-${state.isLoading}-${state.searchTracks}"
                      ),
                      controller: scrollController,
                      showItemInterval: Duration(
                        milliseconds: state.isLoading ? 100 : 200,
                      ),
                      showItemDuration: Duration(milliseconds: state.isLoading ? 500 : 250),
                      // visibleFraction: 0.001,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 75,
                        // childAspectRatio: 2.0,
                      ),
                      itemCount: state.isLoading ? 9 : state.tracksFilters.length,
                      itemBuilder: (context, index, animation) =>
                          FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              child: state.isLoading
                                  ? const TrackSkeleton()
                                  : Track(
                                  id: state.tracksFilters[index].id,
                                  imageUrl: state.tracksFilters[index].imageUrl,
                                  title: state.tracksFilters[index].name,
                                  // subTitle: "3:21 minutos",
                                  subTitle: state
                                      .tracksFilters[index].product.name,
                                  onTap: () => Get.toNamed(
                                      Routes.trackDetails,
                                      arguments: {
                                        'tracks': state.tracksFilters,
                                        'index': index
                                      })),
                            ),
                          )
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/bloc/product/bloc.dart';
import 'package:flutter_music/screens/home/artists/details.dart';
import 'package:flutter_music/widgets/artists/artist.dart';
import 'package:get/get.dart';
import '../../../utils/theme.dart';
import '../../../widgets/artists/artist_skeleton.dart';
import '../../../widgets/list/advanced_list.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late ProductBloc productBloc = context.read<ProductBloc>();
  final int diskForAllId = int.parse(dotenv.env['DISK_FOR_ALL_ID'] as String);
  final scrollController = ScrollController();

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
        child: BlocBuilder<ProductBloc, ProductState>(
            buildWhen: (previous, current) => (previous.isLoading != current.isLoading || previous.singleArtist != current.singleArtist),
            builder: (context, state) {
              if (state.singleArtist != null) {
                return ArtistDetailsScreen(
                  artist: state.singleArtist!,
                );
              }

              return FadeIn(
                animate: true,
                duration: const Duration(seconds: 1),
                child: AdvancedList(
                  title: const Text("Nombres"),
                  searchField: FormBuilderTextField(
                    name: 'search',
                    enabled: !state.isLoading,
                    controller: TextEditingController(
                      text: state.searchArtists,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Buscar nombre',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.lightThreeColor,
                      ),
                    ),
                    onSubmitted: (value) {
                      productBloc.add(SearchEvents(
                        searchArtists: value!,
                      ));
                    },
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Nombres",
                                style: TextStyle(
                                  fontFamily: 'Vogue Bold',
                                  fontSize: 18,
                                ),
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                  buildWhen: (previous, current) =>
                                  previous.isLoading != current.isLoading,
                                  builder: (context, state) {
                                    return Semantics(
                                      label: 'Cantidad de nombres',
                                      child: Text(
                                        state.isLoading
                                            ? ""
                                            : "${state.artistsFilters.length}",
                                        style: const TextStyle(
                                          fontFamily: 'Vogue Bold',
                                          fontSize: 18,
                                        ),
                                      ),
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
                        (previous.isLoading != current.isLoading),
                        builder: (context, state) {
                          if (!state.isLoading && state.artistsFilters.isEmpty) {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: FadeInUp (
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
                                  "artists-${state.isLoading}-${state.searchArtists}"),
                              controller: scrollController,
                              showItemInterval: Duration(
                                milliseconds: state.isLoading ? 100 : 200,
                              ),
                              showItemDuration:
                              Duration(milliseconds: state.isLoading ? 500 : 250),
                              visibleFraction: 0.05,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: context.isPhone ? 3 : 5,
                                mainAxisExtent: 190,
                                crossAxisSpacing: 10,
                              ),
                              itemCount:
                              state.isLoading ? (context.isPhone ? 9 : 27) : state.artistsFilters.length,
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
                                          ? const ArtistSkeleton()
                                          : Artist(
                                        img1: "assets/images/avatar${state.artistsFilters[index].id == diskForAllId ? "2": ""}.png",
                                        title: state.artistsFilters[index].realName,
                                        // subTitle: "${state.artistsFilters[index].products.length} Canciones personalizadas/Cuentos personalizados",
                                        subTitle: "",
                                        onTap: () {
                                          productBloc.add(SetSingleArtistEvent(artist: state.artistsFilters[index]));
                                        },
                                      ),
                                    ),
                                  ));
                        }),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}

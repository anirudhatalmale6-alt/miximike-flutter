import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/widgets/tracks/track.dart';
import 'package:get/get.dart';

import '../../../bloc/product/bloc.dart';
import '../../../utils/routes.dart';
import '../../../utils/theme.dart';
import '../../../widgets/tracks/track_skeleton.dart';

class SearchModal extends StatelessWidget {
  const SearchModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late ProductBloc productBloc = context.read<ProductBloc>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
                buildWhen: (previous, current) =>
                    (previous.isLoading != current.isLoading),
                builder: (context, state) {
                  return FormBuilderTextField(
                    name: 'search',
                    enabled: !state.isLoading,
                    controller: TextEditingController(
                      text: state.generalSearch,
                    ),
                    decoration: const InputDecoration(
                      labelText: '¿Qué deseas buscar?',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.lightThreeColor,
                      ),
                    ),
                    onSubmitted: (value) {
                      productBloc.add(GeneralSearchEvents(
                        search: value!,
                      ));
                    },
                  );
                }),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nombres",
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
                                    : "${state.artistsGeneralFilters.length}",
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
                    BlocBuilder<ProductBloc, ProductState>(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          return LiveList.options(
                              key: ValueKey(
                                  "artists-${state.isLoading}-${state.generalSearch}"),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              options: LiveOptions(
                                showItemInterval: Duration(
                                    milliseconds: state.isLoading ? 100 : 200),
                                showItemDuration: Duration(
                                    milliseconds: state.isLoading ? 500 : 250),
                              ),
                              itemCount: state.artistsGeneralFilters.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
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
                                              id: state
                                                  .artistsGeneralFilters[index]
                                                  .id
                                                  .toString(),
                                              imageUrl:
                                                  'https://miximike.com/wp-content/uploads/2023/08/LOGO-COLOR-ALPHA.png',
                                              title: state
                                                  .artistsGeneralFilters[index]
                                                  .name,
                                              subTitle:
                                                  "${state.artistsGeneralFilters[index].products.length} Canciones personalizadas",
                                              onTap: () => Get.toNamed(
                                                Routes.artistDetails,
                                                arguments: {
                                                  'artist': state
                                                      .artistsFilters[index]
                                                },
                                              ),
                                            ),
                                    ),
                                  ));
                        }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Canciones personalizadas",
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
                                    : "${state.albumsGeneralFilters.length}",
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
                    BlocBuilder<ProductBloc, ProductState>(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          return LiveList.options(
                              key: ValueKey(
                                  "albums-${state.isLoading}-${state.generalSearch}"),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              options: LiveOptions(
                                showItemInterval: Duration(
                                    milliseconds: state.isLoading ? 100 : 200),
                                showItemDuration: Duration(
                                    milliseconds: state.isLoading ? 500 : 250),
                              ),
                              itemCount: state.albumsGeneralFilters.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
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
                                                id: state
                                                    .albumsGeneralFilters[index]
                                                    .id
                                                    .toString(),
                                                imageUrl: state
                                                    .albumsGeneralFilters[index]
                                                    .imageUrl,
                                                title: state
                                                    .albumsGeneralFilters[index]
                                                    .name,
                                                subTitle:
                                                    "${state.albumsGeneralFilters[index].tracks.length} Canciones",
                                                onTap: () => Get.toNamed(
                                                  Routes.productDetails,
                                                  arguments: {
                                                    'product': state
                                                            .albumsGeneralFilters[
                                                        index]
                                                  },
                                                ),
                                              )),
                                  ));
                        }),
                    const SizedBox(height: 20),
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
                                    : "${state.tracksGeneralFilters.length}",
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
                    BlocBuilder<ProductBloc, ProductState>(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          return LiveList.options(
                              key: ValueKey(
                                  "tracks-${state.isLoading}-${state.generalSearch}"),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              options: LiveOptions(
                                showItemInterval: Duration(
                                    milliseconds: state.isLoading ? 100 : 200),
                                showItemDuration: Duration(
                                    milliseconds: state.isLoading ? 500 : 250),
                              ),
                              itemCount: state.tracksGeneralFilters.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
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
                                              id: state
                                                  .tracksGeneralFilters[index]
                                                  .id,
                                              imageUrl: state
                                                  .tracksGeneralFilters[index]
                                                  .product
                                                  .imageUrl,
                                              title: state
                                                  .tracksGeneralFilters[index]
                                                  .name,
                                              // subTitle: "3:21 minutos",
                                              subTitle: state
                                                  .tracksGeneralFilters[index]
                                                  .product
                                                  .name,
                                              onTap: () => Get.toNamed(
                                                      Routes.trackDetails,
                                                      arguments: {
                                                        'tracks': state
                                                            .tracksGeneralFilters,
                                                        'index': index
                                                      })),
                                    ),
                                  ));
                        }),
                    BlocBuilder<ProductBloc, ProductState>(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          if (state.artistsGeneralFilters.isEmpty &&
                              state.albumsGeneralFilters.isEmpty &&
                              state.tracksGeneralFilters.isEmpty) {
                            return FadeInUp(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                    'No se han encontrado resultados en base a tus parámetros de búsqueda.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16)),
                              ),
                            );
                          }

                          return Container();
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

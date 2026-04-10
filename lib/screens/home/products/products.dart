import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/widgets/products/product.dart';
import 'package:get/get.dart';

import '../../../bloc/product/bloc.dart';
import '../../../utils/routes.dart';
import '../../../utils/theme.dart';
import '../../../widgets/list/advanced_list.dart';
import '../../../widgets/products/product_skeleton.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({ super.key });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductBloc productBloc = context.read<ProductBloc>();
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
        child: AdvancedList(
          title: const Text("Canciones personalizadas"),
          searchField: BlocBuilder<ProductBloc, ProductState>(
              buildWhen: (previous, current) => (previous.isLoading != current.isLoading),
              builder: (context, state) {
                return FormBuilderTextField(
                  name: 'search',
                  enabled: !state.isLoading,
                  controller: TextEditingController(
                    text: state.searchAlbums,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Buscar Canciones personalizadas',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.lightThreeColor,
                    ),
                  ),
                  onSubmitted: (value) {
                    productBloc.add(
                        SearchEvents(
                          searchAlbums: value!,
                        )
                    );
                  },
                );
              }
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Canciones personalizadas",
                        style: TextStyle(
                          fontFamily: 'Vogue Bold',
                          fontSize: 18,
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                          builder: (context, state) {
                            return Text(
                              state.isLoading ? "" : "${state.albumsFilters.length}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Vogue Bold'
                              ),
                            );
                          }
                      )
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
                buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (!state.isLoading && state.albumsFilters.isEmpty) {
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
                                style: TextStyle(
                                    fontSize: 16
                                )
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return LiveSliverGrid(
                      key: ValueKey("albums-${state.isLoading}-${state.searchAlbums}"),
                      controller: scrollController,
                      showItemInterval: Duration(
                        milliseconds: state.isLoading ? 100 : 200,
                      ),
                      showItemDuration: Duration(
                          milliseconds: state.isLoading ? 500 : 250
                      ),
                      visibleFraction: 0.05,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 245,
                      ),
                      itemCount: state.isLoading ? 9 : state.albumsFilters.length,
                      itemBuilder: (context, index, animation) => FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: state.isLoading ? const ProductSkeleton() : Product(
                            imageUrl: state.albumsFilters[index].imageUrl,
                            title: state.albumsFilters[index].name,
                            subTitle: "${state.albumsFilters[index].tracks.length} Canciones",
                            onTap: () => Get.toNamed(
                              Routes.productDetails,
                              arguments: {
                                'product': state.albumsFilters[index]
                              },
                            ),
                          ),
                        ),
                      )
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

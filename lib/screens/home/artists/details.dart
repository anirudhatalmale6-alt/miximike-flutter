import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_music/api/models/artist.dart';
import 'package:flutter_music/api/models/product.dart';
import 'package:flutter_music/bloc/product/bloc.dart';
import 'package:flutter_music/screens/home/products/details.dart';
import 'package:flutter_music/utils/theme.dart';

class ArtistDetailsScreen extends StatefulWidget {
  const ArtistDetailsScreen({super.key, required this.artist});
  final Artist artist;

  @override
  State<ArtistDetailsScreen> createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  final int diskForAllId = int.parse(dotenv.env['DISK_FOR_ALL_ID'] as String);
  late final Artist artist = widget.artist;
  late List<Product> disks =
  artist.products.where((e) => e.type == ProductType.disk).toList();
  late List<Product> audioBooks =
  artist.products.where((e) => e.type == ProductType.audioBook).toList();
  late List<Product> diskForAll =
  artist.products.where((e) => e.type == ProductType.diskForAll).toList();
  late List<Product> diskForAllMix = disks + diskForAll;

  late ProductBloc productBloc = context.read<ProductBloc>();
  String titleProductDetails = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) => previous.singleProducts != current.singleProducts,
        builder: (context, state) {
          if (state.singleProducts.isNotEmpty) {
            return ProductDetailsScreen(
              title: titleProductDetails,
              products: state.singleProducts,
              artist: artist,
            );
          }

          if (artist.isOnlyDiskForAll) {
            return ProductDetailsScreen(
              title: "Canciones para todos",
              products: artist.products,
              artist: artist,
            );
          }

          return FadeIn(
            animate: true,
            duration: const Duration(seconds: 1),
            child: PopScope(
              canPop: false,
                onPopInvokedWithResult : (didPop, result) {
                if (didPop) {
                  return;
                }
                if (state.artists.length == 1) return;

                productBloc.add(SetSingleArtistEvent(artist: null));
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(artist.name),
                  leading: BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) => previous.artists != current.artists,
                      builder: (context, state) {
                        // TODO: CAMBIAR POR 1
                        if (state.artists.length == 1) {
                          return Container();
                        }
                        return IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            productBloc.add(SetSingleArtistEvent(artist: null));
                          },
                        );
                      }
                  ),
                  leadingWidth: state.artists.length == 1 ? 0 : 40,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Column(
                            children: [
                              const CircleAvatar(
                                radius: 75,
                                backgroundImage: AssetImage(
                                  "assets/images/avatar2.png",
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                artist.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Vogue Bold',
                                  fontSize: 32,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Text(
                              //   '${artist.products.length} Canciones personalizadas y Cuentos personalizados  |  ${artist.tracks.length} Canciones y Cuentos personalizados',
                              //   textAlign: TextAlign.center,
                              //   style: const TextStyle(
                              //     fontSize: 12,
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: disks.isEmpty ? Colors.grey : null,
                              ),
                              onPressed: () {
                                if (disks.isNotEmpty) {
                                  titleProductDetails = 'Canciones personalizadas';
                                  productBloc.add(SetSingleProductsEvent(products: disks));
                                  // Get.toNamed(
                                  //   Routes.productDetails,
                                  //   arguments: {
                                  //     'artist': artist,
                                  //     'products': disks,
                                  //     // 'type': ProductType.disk,
                                  //     'title': 'Canciones personalizadas',
                                  //   },
                                  // );
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CANCIONES PERSONALIZADAS",
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
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: audioBooks.isEmpty ? Colors.grey : null,
                              ),
                              onPressed: () {
                                if (audioBooks.isNotEmpty) {
                                  titleProductDetails = 'Cuentos personalizados';
                                  productBloc.add(SetSingleProductsEvent(products: audioBooks));
                                  // Get.toNamed(
                                  //   Routes.productDetails,
                                  //   arguments: {
                                  //     'artist': artist,
                                  //     'products': audioBooks,
                                  //     'type': ProductType.audioBook,
                                  //     'title': 'Cuentos personalizados',
                                  //   },
                                  // );
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CUENTOS  PERSONALIZADOS",
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
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: state.diskForAll == null ? Colors.grey : null,
                              ),
                              onPressed: () {
                                if (state.diskForAll != null) {
                                  titleProductDetails = 'Canciones para todos';
                                  // productBloc.add(SetSingleProductsEvent(products: diskForAll));
                                  productBloc.add(SetSingleProductsEvent(products: state.diskForAll!.products));
                                  // Get.toNamed(
                                  //   Routes.productDetails,
                                  //   arguments: {
                                  //     'artist': artist,
                                  //     'products': diskForAll,
                                  //     'type': ProductType.diskForAll,
                                  //     'title': 'Canciones para todos',
                                  //   },
                                  // );
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CANCIONES PARA TODOS",
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
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: diskForAllMix.isEmpty ? Colors.grey : null,
                              ),
                              onPressed: () {
                                if (diskForAllMix.isNotEmpty || state.diskForAll != null) {
                                  titleProductDetails = 'Mix todas las canciones';
                                  List<Product> products = diskForAllMix;

                                  if (state.diskForAll != null) {
                                    products += state.diskForAll!.products;
                                  }

                                  products = products.toSet().toList();

                                  products.sort((a, b) => a.order.date.compareTo(b.order.date));

                                  productBloc.add(
                                      SetSingleProductsEvent(
                                          products: products,
                                      )
                                  );
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MIX TODAS LAS CANCIONES",
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
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            ],
                          ),
                          // if (disks.isNotEmpty)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 10),
                          //     child: ProductDetailList(
                          //       title: 'Canciones personalizadas',
                          //       productSubtitle: 'Canciones',
                          //       titleAllProducts: 'Todos los discos',
                          //       products: disks,
                          //     ),
                          //   ),
                          // if (audioBook.isNotEmpty)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 10),
                          //     child: ProductDetailList(
                          //       title: 'Cuentos personalizados',
                          //       productSubtitle: 'Cuentos',
                          //       titleAllProducts: 'Todos los Cuentos personalizados',
                          //       products: audioBook,
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

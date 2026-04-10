import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_music/api/models/order.dart';
import 'package:flutter_music/api/models/product.dart';
import 'package:get/get.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../api/client.dart';
import '../../api/models/artist.dart';
import '../../api/models/track.dart';

part 'events.dart';
part 'state.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  ProductBloc({
    ProductState initialState = const ProductState(),
  }) : super(initialState) {
    on<InitProductEvent>(_initProduct);
    on<SearchEvents>(_search);
    on<GeneralSearchEvents>(_generalSearch);
    on<SetSingleArtistEvent>(_setSingleArtistEvent);
    on<SetSingleProductsEvent>(_setSingleProductEvent);
  }

  Future<void> _initProduct(
      InitProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));

    List<dynamic> excludeProductsId =
    json.decode(dotenv.env['WOOCOMMERCE_EXCLUDE_PRODUCTS_ID'] as String);
    // int diskForAllId = int.parse(dotenv.env['DISK_FOR_ALL_ID'] as String);

    List<Order> orders = await getOrders(forceReload: event.forceReload);

    List<dynamic> downloads =
    await ProductClient.getDownloads(forceReload: event.forceReload)
        .then((response) => response)
        .onError<DioException>((error, stackTrace) => []);
    String includeProducts = orders
        .map<List<int>>((e) => e.products)
        .expand<int>((element) => element)
        .toList()
        .toSet()
        .toList()
        .join(',');
    List<Product> products =
    await getProducts(forceReload: event.forceReload, queryParameters: {
      'include': includeProducts.isNotEmpty ? includeProducts : '-1',
      'exclude': excludeProductsId.join(','),
    })
      ..forEach((e) => e
        ..fromCategories()
        ..setIsAll()
        ..setTracks(downloads
            .where((download) => download['product_id'] == e.id)
            .toList())
        ..setOrder(orders));
    products = products.where((element) => !element.isAll).toList()..sort((a, b) => a.order.date.compareTo(b.order.date));
    List<Artist> artists = products
        .where((element) => element.artist.name != '-?')
        .map((e) => e.artist).toSet().toList()
      ..forEach((element) => element.setRelations(products));
    List<Track> tracks = products
        .map((e) => e.tracks)
        .expand((element) => element)
        .toSet()
        .toList();

    artists.sort((a, b) => a.realName.compareTo(b.realName));

    Artist? diskForAll = artists.firstWhereOrNull((element) => element.products.any((product) => product.type == ProductType.diskForAll));

    // artists.removeWhere((element) => element.id == diskForAllId);

    emit(state.copyWith(
      isLoading: false,
      orders: orders,
      artists: artists,
      diskForAll: diskForAll,
      albums: products,
      tracks: tracks,
      generalSearch: '',
      artistsGeneralFilters: artists,
      albumsGeneralFilters: products,
      tracksGeneralFilters: tracks,
      searchArtists: '',
      searchAlbums: '',
      searchTracks: '',
      artistsFilters: artists,
      albumsFilters: products,
      tracksFilters: tracks,
      // TODO OJO CON ESTO. CAMBIAR A 1
      // singleArtist: artists.length == 1 ? artists.first : null,
      cleanSingleArtist: artists.length != 1,
    ));
  }

  void _search(SearchEvents event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      isLoading: true,
    ));

    const double minimalSimilarity = 0.3;
    RegExp cleanRegExp = RegExp(r'[^\w\s]+');

    String searchArtist = event.searchArtists ?? state.searchArtists;
    String searchAlbum = event.searchAlbums ?? state.searchAlbums;
    String searchTrack = event.searchTracks ?? state.searchTracks;

    List<String> searchArtists =
    searchArtist.replaceAll(cleanRegExp, '').toLowerCase().split(' ');
    List<String> searchAlbums =
    searchAlbum.replaceAll(cleanRegExp, '').toLowerCase().split(' ');
    List<String> searchTracks =
    searchTrack.replaceAll(cleanRegExp, '').toLowerCase().split(' ');

    List<Artist> artistsFilters = state.artists
        .where(
          (e) =>
      [null, ''].contains(searchArtist) ||
          e.realName.replaceAll(cleanRegExp, '').toLowerCase().split(' ').any(
                  (name) => searchArtists.any((toSearch) =>
              toSearch.similarityTo(name) >= minimalSimilarity ||
                  name.contains(toSearch))),
    )
        .toList();

    List<Product> albumsFilters = state.albums
        .where(
          (e) =>
      [null, ''].contains(searchAlbum) ||
          e.name.replaceAll(cleanRegExp, '').toLowerCase().split(' ').any(
                  (name) => searchAlbums.any((toSearch) =>
              toSearch.similarityTo(name) >= minimalSimilarity ||
                  name.contains(toSearch))),
    )
        .toList();

    List<Track> tracksFilters = state.tracks
        .where((e) =>
    [null, ''].contains(searchTrack) ||
        e.name
            .replaceAll(cleanRegExp, '')
            .toLowerCase()
            .split(' ')
            .any((name) => searchTracks.any((toSearch) => toSearch.similarityTo(name) >= minimalSimilarity || name.contains(toSearch))
        ),
    ).where((e) => event.searchTypeTracks == ProductType.mix
        ? [ProductType.disk, ProductType.diskForAll].contains(e.product.type)
        : (event.searchTypeTracks ?? state.searchTypeTracks) == e.product.type
    ).toList()..sort((a, b) => a.product.order.date.compareTo(b.product.order.date));

    emit(state.copyWith(
      isLoading: false,
      searchArtists: event.searchArtists,
      artistsFilters: artistsFilters,
      searchAlbums: event.searchAlbums,
      albumsFilters: albumsFilters,
      searchTracks: event.searchTracks,
      searchTypeTracks: event.searchTypeTracks,
      tracksFilters: tracksFilters,
    ));
  }

  void _generalSearch(GeneralSearchEvents event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      isLoading: true,
    ));

    const double minimalSimilarity = 0.3;
    RegExp cleanRegExp = RegExp(r'[^\w\s]+');

    List<String> searches =
    event.search.replaceAll(cleanRegExp, '').toLowerCase().split(' ');

    emit(state.copyWith(
      isLoading: false,
      generalSearch: event.search,
      artistsGeneralFilters: state.artists
          .where(
            (e) =>
        [null, ''].contains(event.search) ||
            e.name.replaceAll(cleanRegExp, '').toLowerCase().split(' ').any(
                    (name) => searches.any((toSearch) =>
                toSearch.similarityTo(name) >= minimalSimilarity ||
                    name.contains(toSearch))),
      )
          .toList(),
      albumsGeneralFilters: state.albums
          .where(
            (e) =>
        [null, ''].contains(event.search) ||
            e.name.replaceAll(cleanRegExp, '').toLowerCase().split(' ').any(
                    (name) => searches.any((toSearch) =>
                toSearch.similarityTo(name) >= minimalSimilarity ||
                    name.contains(toSearch))),
      )
          .toList(),
      tracksGeneralFilters: state.tracks
          .where(
            (e) =>
        [null, ''].contains(event.search) ||
            e.name.replaceAll(cleanRegExp, '').toLowerCase().split(' ').any(
                    (name) => searches.any((toSearch) =>
                toSearch.similarityTo(name) >= minimalSimilarity ||
                    name.contains(toSearch))),
      )
          .toList(),
    ));
  }

  void _setSingleArtistEvent(SetSingleArtistEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      singleArtist: event.artist,
      cleanSingleArtist: event.artist == null,
    ));
  }

  void _setSingleProductEvent(SetSingleProductsEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(
      singleProducts: event.products,
    ));
  }

  Future<List<Order>> getOrders({required bool forceReload}) async =>
      await ProductClient.getOrders(forceReload: forceReload)
          .then((response) =>
          response.map<Order>((json) => Order.fromJson(json)).toList())
          .onError<DioException>((error, stackTrace) => [] as List<Order>);

  Future<List<Product>> getProducts(
      {Map<String, dynamic> queryParameters = const {},
        required bool forceReload}) async {
    return await ProductClient.getProducts(
        forceReload: forceReload, queryParameters: queryParameters)
        .then((response) =>
        response.map<Product>((json) => Product.fromJson(json)).toList())
        .onError<DioException>((error, stackTrace) => [] as List<Product>);
  }
}

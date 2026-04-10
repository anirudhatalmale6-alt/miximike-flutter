part of 'bloc.dart';

abstract class ProductEvents {}

class InitProductEvent extends ProductEvents {
  final bool forceReload;

  InitProductEvent({
    this.forceReload = false,
  });
}

class SearchArtistsEvent extends ProductEvents {
  final String search;

  SearchArtistsEvent({
    required this.search,
  });
}

class SearchEvents extends ProductEvents {
  final String? searchArtists;
  final String? searchAlbums;
  final String? searchTracks;
  final ProductType? searchTypeTracks;

  SearchEvents({
    this.searchArtists,
    this.searchAlbums,
    this.searchTracks,
    this.searchTypeTracks,
  });
}

class GeneralSearchEvents extends ProductEvents {
  final String search;

  GeneralSearchEvents({
    required this.search,
  });
}

class SetSingleArtistEvent extends ProductEvents {
  final Artist? artist;

  SetSingleArtistEvent({
    required this.artist,
  });
}

class SetSingleProductsEvent extends ProductEvents {
  final List<Product> products;

  SetSingleProductsEvent({
    required this.products,
  });
}
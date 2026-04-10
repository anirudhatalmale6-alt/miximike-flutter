part of 'bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final List<Order> orders;
  final List<Artist> artists;
  final List<Product> albums;
  final Artist? diskForAll;
  final List<Track> tracks;

  final String generalSearch;
  final List<Artist> artistsGeneralFilters;
  final List<Product> albumsGeneralFilters;
  final List<Track> tracksGeneralFilters;

  final String searchArtists;
  final String searchAlbums;
  final String searchTracks;
  final Artist? singleArtist;
  final ProductType searchTypeTracks;
  final List<Artist> artistsFilters;
  final List<Product> albumsFilters;
  final List<Track> tracksFilters;
  final List<Product> singleProducts;

  const ProductState({
    this.isLoading = false,
    this.orders = const [],
    this.artists = const [],
    this.albums = const [],
    this.diskForAll,
    this.tracks = const [],

    this.generalSearch = '',
    this.artistsGeneralFilters = const [],
    this.albumsGeneralFilters = const [],
    this.tracksGeneralFilters = const [],

    this.searchArtists = '',
    this.searchAlbums = '',
    this.searchTracks = '',
    this.singleArtist,
    this.searchTypeTracks = ProductType.disk,
    this.artistsFilters = const [],
    this.albumsFilters = const [],
    this.tracksFilters = const [],
    this.singleProducts = const [],
  });

  @override
  List<Object?> get props => [
    isLoading,
    orders.length,
    artists.length,
    albums.length,
    diskForAll,
    tracks.length,

    generalSearch,
    artistsGeneralFilters.length,
    albumsGeneralFilters.length,
    tracksGeneralFilters.length,

    searchArtists,
    searchAlbums,
    searchTracks,
    searchTypeTracks,
    singleArtist,
    artistsFilters.length,
    albumsFilters.length,
    tracksFilters.length,
    singleProducts.length,
  ];

  ProductState copyWith({
    bool? isLoading,
    List<Order>? orders,
    List<Artist>? artists,
    List<Product>? albums,
    Artist? diskForAll,
    List<Track>? tracks,
    String? generalSearch,
    List<Artist>? artistsGeneralFilters,
    List<Product>? albumsGeneralFilters,
    List<Track>? tracksGeneralFilters,
    String? searchArtists,
    String? searchAlbums,
    String? searchTracks,
    Artist? singleArtist,
    ProductType? searchTypeTracks,
    List<Artist>? artistsFilters,
    List<Product>? albumsFilters,
    List<Track>? tracksFilters,
    List<Product>? singleProducts,
    bool cleanSingleArtist = false,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      diskForAll: diskForAll ?? this.diskForAll,
      tracks: tracks ?? this.tracks,

      generalSearch: generalSearch ?? this.generalSearch,
      artistsGeneralFilters: artistsGeneralFilters ?? this.artistsGeneralFilters,
      albumsGeneralFilters: albumsGeneralFilters ?? this.albumsGeneralFilters,
      tracksGeneralFilters: tracksGeneralFilters ?? this.tracksGeneralFilters,

      searchArtists: searchArtists ?? this.searchArtists,
      searchAlbums: searchAlbums ?? this.searchAlbums,
      searchTracks: searchTracks ?? this.searchTracks,
      singleArtist: cleanSingleArtist ? null : (singleArtist ?? this.singleArtist),
      searchTypeTracks: searchTypeTracks ?? this.searchTypeTracks,
      artistsFilters: artistsFilters ?? this.artistsFilters,
      albumsFilters: albumsFilters ?? this.albumsFilters,
      tracksFilters: tracksFilters ?? this.tracksFilters,
      singleProducts: singleProducts ?? this.singleProducts,
    );
  }
}

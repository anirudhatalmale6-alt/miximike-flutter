import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_music/api/models/artist.dart';
import 'package:flutter_music/api/models/order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'track.dart';

part 'product.g.dart';

enum ProductType { disk, audioBook, diskForAll, mix }

@JsonSerializable()
class Product with EquatableMixin {
  final int id;
  final String name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool isAll;
  @JsonKey(name: 'images', fromJson: readImage)
  final String imageUrl;
  @JsonKey(name: 'tags', fromJson: readTags)
  final ProductType type;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late Artist artist;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late List<Track> tracks;
  @JsonKey()
  final List<Map<String, dynamic>> categories;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late Order order;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.categories,
    this.isAll = false,
    this.tracks = const [],
  });

  @override
  List<Object> get props => [
    id,
  ];

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static String readImage(List<dynamic> list) => list.first?['src'];

  static ProductType readTags(List<dynamic> list)  {
    Map<String, ProductType> stringToType = {
      'disco-de-canciones': ProductType.disk,
      'audiolibro': ProductType.audioBook,
      'canciones-para-todos': ProductType.diskForAll,
    };

    return stringToType[
    list.firstWhere((e) => stringToType.containsKey(e['slug']), orElse: () => null)?['slug']
    ] ?? ProductType.disk;
  }

  static bool readIsAll(List<dynamic> list) {
    int todoId = int.parse(dotenv.env['WOOCOMMERCE_TODO_CATEGORY_ID'] as String);

    return list.any((element) => element['id'] == todoId);
  }

  void fromCategories() {
    List<dynamic> excludeIds = json.decode(dotenv.env['WOOCOMMERCE_EXCLUDE_CATEGORIES_ID']!) as List<dynamic>;

    artist = Artist.fromJson({
      ...categories.firstWhere((element) => !excludeIds.contains(element['id']), orElse: () => {}),
      'productCount': 0,
    });
  }

  void setArtist(Artist artist) => this.artist = artist;

  void setIsAll() {
    int todoId = int.parse(dotenv.env['WOOCOMMERCE_TODO_CATEGORY_ID'] as String);

    isAll = categories.any((element) => element['id'] == todoId);
  }

  void setTracks(List<dynamic> json) {
    tracks = json.map((e) => Track(
      id: e['download_id'],
      name: e['download_name'],
      url: e['download_url'],
      product: this,
    )).toSet().toList();
  }

  void setOrder(List<Order> orders) {
    for (var element in orders) {
      if (element.products.contains(id)) {
        order = element;
        break;
      }
    }
  }
}

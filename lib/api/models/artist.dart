import 'package:equatable/equatable.dart';
import 'package:flutter_music/api/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

import './track.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist with EquatableMixin {
  final int id;
  final String name;
  List<Product> products;
  List<Track> tracks;

  Artist({
    required this.id,
    required this.name,
    this.products = const [],
    this.tracks = const [],
  });

  @override
  List<Object> get props => [
    id,
  ];

  bool get isOnlyDiskForAll => products.every((element) => element.type == ProductType.diskForAll);
  String get realName => isOnlyDiskForAll ? 'CANCIONES PARA TODOS' : name;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  void setRelations(List<Product> list) {
    products = list.where((product) => product.artist.id == id).toList();
    tracks = products.map((e) => e.tracks).expand((element) => element).toList();
  }
}

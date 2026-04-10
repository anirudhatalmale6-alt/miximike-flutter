import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:slugify/slugify.dart';

import 'product.dart';

part 'track.g.dart';

@JsonSerializable()
class Track with EquatableMixin {
  final String id;
  final String name;
  @JsonKey(name: 'file')
  final String url;
  final Product product;
  String get imageUrl => isLocal
      ? '${dotenv.env['BASE_SERVICE_URL'] as String}wp-content/uploads/2024/07/'
      '${url.replaceAll('assets/demo/', '').replaceAll('.mp3', '')}.png'
      : '${dotenv.env['BASE_SERVICE_URL'] as String}wp-content/uploads/portadas-canciones/'
      '${slugify(name.split(' - ').first, lowercase: true, delimiter: '-')}.jpg';


  Track({
    required this.id,
    required this.name,
    required String url,
    required this.product,
  }) : url = url.startsWith('http://') ? url.replaceFirst('http://', 'https://') : url;

  @override
  List<Object> get props => [
    id,
  ];

  bool get isLocal  => !url.contains('http');

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: Product.readImage(json['images'] as List),
      type: Product.readTags(json['tags'] as List),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.imageUrl,
      'tags': _$ProductTypeEnumMap[instance.type]!,
      'categories': instance.categories,
    };

const _$ProductTypeEnumMap = {
  ProductType.disk: 'disk',
  ProductType.audioBook: 'audioBook',
};

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  @JsonKey(name: 'line_items', fromJson: _readLineItems)
  final List<int> products;
  @JsonKey(name: 'date_paid', fromJson: _datePaid)
  final DateTime date;

  Order({
    required this.id,
    required this.products,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  static List<int> _readLineItems(List<dynamic> list) {
    List<dynamic> excludeProductsId = json.decode(dotenv.env['WOOCOMMERCE_EXCLUDE_PRODUCTS_ID'] as String);
    
    return list.map<int>((e) => e['product_id']).where((element) => !excludeProductsId.contains(element)).toList();
  }
  static DateTime _datePaid(String datetime) {
    return DateTime.parse(datetime);
  }
}

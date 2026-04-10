import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification with EquatableMixin {
  final int id;
  @JsonKey(fromJson: readTitle)
  final String title;
  @JsonKey(fromJson: readDateTime)
  final String content;
  @JsonKey(name: 'date', fromJson: readCreatedAt)
  final DateTime createdAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool view;

  String get cleanContent =>
      content.trim().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

  String get cleanTitle =>
      title.trim().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

  Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.view = true,
  });

  @override
  List<Object> get props => [
        id,
      ];

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  static String readTitle(Map<String, dynamic> data) => data['rendered'];

  static String readDateTime(Map<String, dynamic> data) => data['rendered'];

  static DateTime readCreatedAt(String datetime) => DateTime.parse(datetime);

  void setView(bool view) => this.view = view;
}

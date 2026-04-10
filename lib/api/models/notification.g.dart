// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as int,
      title: Notification.readTitle(json['title'] as Map<String, dynamic>),
      content:
          Notification.readDateTime(json['content'] as Map<String, dynamic>),
      createdAt: Notification.readCreatedAt(json['date'] as String),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.createdAt.toIso8601String(),
    };

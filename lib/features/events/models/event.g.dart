// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
      sessionId: json['sessionId'] as String?,
      eventName: json['eventName'] as String,
      urlPath: json['urlPath'] as String,
      referrerDomain: json['referrerDomain'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'createdAt': instance.createdAt.toIso8601String(),
      'eventName': instance.eventName,
      'urlPath': instance.urlPath,
      'referrerDomain': instance.referrerDomain,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      browser: json['browser'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      city: json['city'] as String,
      country: json['country'] as String,
      device: json['device'] as String,
      id: json['id'] as String,
      os: json['os'] as String,
      region: json['region'] as String,
      screen: json['screen'] as String,
      visits: (json['visits'] as num).toInt(),
      views: (json['views'] as num).toInt(),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'browser': instance.browser,
      'os': instance.os,
      'device': instance.device,
      'screen': instance.screen,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'visits': instance.visits,
      'views': instance.views,
      'createdAt': instance.createdAt.toIso8601String(),
    };

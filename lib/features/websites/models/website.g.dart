// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Website _$WebsiteFromJson(Map<String, dynamic> json) => Website(
      id: json['id'] as String,
      name: json['name'] as String,
      domain: json['domain'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WebsiteToJson(Website instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain': instance.domain,
      'createdAt': instance.createdAt.toIso8601String(),
    };

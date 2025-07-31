// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageview _$PageviewFromJson(Map<String, dynamic> json) => Pageview(
      pageviews: (json['pageviews'] as List<dynamic>)
          .map((e) => Metric.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => Metric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageviewToJson(Pageview instance) => <String, dynamic>{
      'pageviews': instance.pageviews,
      'sessions': instance.sessions,
    };

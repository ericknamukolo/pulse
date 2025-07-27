// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Metric _$MetricFromJson(Map<String, dynamic> json) => Metric(
      x: json['x'] as String,
      y: (json['y'] as num).toInt(),
    );

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

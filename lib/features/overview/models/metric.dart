import 'package:json_annotation/json_annotation.dart';
part 'metric.g.dart';

@JsonSerializable()
class Metric {
  String x;
  int y;

  Metric({
    required this.x,
    required this.y,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
  Map<String, dynamic> toJson() => _$MetricToJson(this);

  static List<Metric> toList(List<dynamic> dataList) {
    List<Metric> loadedMetrics = [];
    for (var metric in dataList) {
      Metric met = Metric.fromJson(metric);

      loadedMetrics.add(met);
    }
    return loadedMetrics;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:pulse/features/overview/models/metric.dart';
part 'pageview.g.dart';

@JsonSerializable()
class Pageview {
  List<Metric> pageviews;
  List<Metric> sessions;

  factory Pageview.fromJson(Map<String, dynamic> json) =>
      _$PageviewFromJson(json);
  Map<String, dynamic> toJson() => _$PageviewToJson(this);

  Pageview({required this.pageviews, required this.sessions});
}

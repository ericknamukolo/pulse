import 'package:pulse/features/overview/models/metric.dart';
import 'package:pulse/features/overview/models/pageview.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class OverviewRepo {
  Future<Map<String, dynamic>?> getSummaryStats(
      {required String id, DateTime? start, DateTime? end}) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        endpoint:
            '${Endpoints.websites}/$id/stats?startAt=$startAt&endAt=$endAt');

    return res;
  }

  double getPercentage({required int current, required int previous}) {
    if (previous == 0) return 0.0;
    return ((current - previous) / previous) * 100;
  }

  Future<List<Metric>> getMetrics(
      {required String metric,
      required String id,
      DateTime? start,
      DateTime? end}) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        endpoint:
            '${Endpoints.websites}/$id/metrics?startAt=$startAt&endAt=$endAt&type=${metric.toLowerCase()}');
    return Metric.toList(res);
  }

  double getMetricPercentage(int val, List<int> total) {
    if (total.isEmpty) return 0.0;
    return (val / total.reduce((a, b) => a + b)) * 100;
  }

  Future<Pageview> getPageviewStats({
    required String unit,
    required String id,
    DateTime? start,
    DateTime? end,
  }) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        endpoint:
            '${Endpoints.websites}/$id/pageviews?startAt=$startAt&endAt=$endAt&unit=${unit.toLowerCase()}&timezone=$userTimeZone');

    return Pageview.fromJson(res);
  }
}

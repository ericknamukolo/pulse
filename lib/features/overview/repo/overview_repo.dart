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
}

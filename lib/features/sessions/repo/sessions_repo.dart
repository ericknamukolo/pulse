import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class SessionsRepo {
  Future<void> getSessions(
      {required String id, DateTime? start, DateTime? end}) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        useKey: true,
        endpoint:
            '${Endpoints.websites.replaceAll(Endpoints.baseUrl, 'https://api.umami.is/v1')}/$id/sessions?startAt=$startAt&endAt=$endAt');
    logger.i(res);
  }
}

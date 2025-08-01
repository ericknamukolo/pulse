import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class SessionsRepo {
  Future<List<Session>> getSessions({
    required String id,
    DateTime? start,
    DateTime? end,
    int? pageNumber,
  }) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        useKey: true,
        endpoint:
            '${Endpoints.websites.replaceAll(Endpoints.baseUrl, 'https://api.umami.is/v1')}/$id/sessions?startAt=$startAt&endAt=$endAt&pageSize=20&page=${pageNumber ?? 1}');
    return Session.toList(res['data']);
  }

  Future<Session?> getSession(String websiteId, String id) async {
    var res = await Requests.get(
        useKey: true,
        endpoint:
            '${Endpoints.websites.replaceAll(Endpoints.baseUrl, 'https://api.umami.is/v1')}/$websiteId/sessions/$id');

    return Session.fromJson(res);
  }

  Future<List<Event>> getSessionEvents({
    required String websiteId,
    required String id,
    DateTime? start,
    DateTime? end,
  }) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;
    var res = await Requests.get(
        useKey: true,
        endpoint:
            '${Endpoints.websites.replaceAll(Endpoints.baseUrl, 'https://api.umami.is/v1')}/$websiteId/sessions/$id/activity?startAt=$startAt&endAt=$endAt');
    logger.i(res);
    return Event.toList(res);
  }
}

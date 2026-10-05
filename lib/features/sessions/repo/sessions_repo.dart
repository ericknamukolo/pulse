import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';

class SessionsRepo {
  /// Sessions endpoint on the user's own server.
  ///
  /// The original code rewrote the URL to `api.umami.is/v1` (Umami Cloud
  /// only) and authenticated with an `x-umami-api-key` header from .env,
  /// which breaks self-hosted instances. Self-hosted servers expose the
  /// same endpoints under `/api/websites/{id}/sessions` and accept the
  /// JWT used everywhere else in the app.
  String _sessionsBase() => Endpoints.websites;

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
        endpoint:
            '${_sessionsBase()}/$id/sessions?startAt=$startAt&endAt=$endAt&pageSize=20&page=${pageNumber ?? 1}');
    return Session.toList(res?['data'] ?? []);
  }

  Future<Session?> getSession(String websiteId, String id) async {
    var res = await Requests.get(
        endpoint: '${_sessionsBase()}/$websiteId/sessions/$id');

    return Session.fromJson(res);
  }

  Future<List<Event>> getSessionEvents({
    required String websiteId,
    required String id,
    required DateTime start,
    required DateTime end,
  }) async {
    int startAt = (start).millisecondsSinceEpoch;
    int endAt = (end).millisecondsSinceEpoch;
    var res = await Requests.get(
        endpoint:
            '${_sessionsBase()}/$websiteId/sessions/$id/activity?startAt=$startAt&endAt=$endAt');
    final data = (res ?? []) as List<dynamic>;
    return Event.toList(
        data.where((e) => e['eventName'] != null).toList());
  }
}

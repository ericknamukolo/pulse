import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';

class EventsRepo {
  /// Fetches custom events (pageviews excluded) for a website.
  ///
  /// Umami >= 3 mixes pageviews and custom events in `/events`, with
  /// `eventName` null for pageviews — those are filtered out here so the
  /// Events tab shows only named events, like the Umami dashboard does.
  Future<List<Event>> getEvents(
      {required String id, DateTime? start, DateTime? end}) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        endpoint:
            '${Endpoints.websites}/$id/events?startAt=$startAt&endAt=$endAt&pageSize=100');

    final data = (res?['data'] ?? []) as List<dynamic>;
    return Event.toList(
        data.where((e) => e['eventName'] != null).toList());
  }
}

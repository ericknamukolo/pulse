import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';

class EventsRepo {
  Future<List<Event>> getEvents(
      {required String id, DateTime? start, DateTime? end}) async {
    var now = DateTime.now();
    int startAt = (start ?? now.subtract(const Duration(hours: 24)))
        .millisecondsSinceEpoch;
    int endAt = (end ?? now).millisecondsSinceEpoch;

    var res = await Requests.get(
        endpoint:
            '${Endpoints.websites}/$id/events?startAt=$startAt&endAt=$endAt&pageSize=100');

    return Event.toList(res['data']);
  }
}

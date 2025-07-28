import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String sessionId;
  DateTime createdAt;
  String eventName;
  String urlPath;
  String referrerDomain;

  Event({
    required this.createdAt,
    required this.id,
    required this.sessionId,
    required this.eventName,
    required this.urlPath,
    required this.referrerDomain,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  static List<Event> toList(List<dynamic> dataList) {
    List<Event> loadedEvents = [];
    for (var event in dataList) {
      Event ev = Event.fromJson(event);

      loadedEvents.add(ev);
    }
    return loadedEvents;
  }
}

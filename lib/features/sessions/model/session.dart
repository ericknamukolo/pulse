import 'package:json_annotation/json_annotation.dart';
part 'session.g.dart';

@JsonSerializable()
class Session {
  String id;
  String browser;
  String os;
  String device;
  String screen;
  String country;
  String region;
  String city;
  int visits;
  int views;
  DateTime createdAt;

  Session({
    required this.browser,
    required this.createdAt,
    required this.city,
    required this.country,
    required this.device,
    required this.id,
    required this.os,
    required this.region,
    required this.screen,
    required this.visits,
    required this.views,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  static List<Session> toList(List<dynamic> dataList) {
    List<Session> loadedSessions = [];
    for (var session in dataList) {
      Session sesh = Session.fromJson(session);

      loadedSessions.add(sesh);
    }
    return loadedSessions;
  }
}

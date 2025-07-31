import 'package:json_annotation/json_annotation.dart';
part 'session.g.dart';

@JsonSerializable()
class Session {
  String id;
  String browser;
  String websiteId;
  String os;
  String device;
  String screen;
  String country;
  String language;
  String region;
  String city;
  int visits;
  int views;
  int? totaltime;
  int? events;
  DateTime? createdAt;
  DateTime firstAt;
  DateTime lastAt;

  Session({
    required this.browser,
    required this.websiteId,
    this.createdAt,
    required this.city,
    required this.country,
    required this.device,
    required this.id,
    required this.os,
    required this.region,
    required this.screen,
    required this.visits,
    required this.views,
    required this.firstAt,
    required this.lastAt,
    required this.language,
    this.events,
    this.totaltime,
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

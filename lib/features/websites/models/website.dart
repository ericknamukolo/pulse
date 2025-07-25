import 'package:json_annotation/json_annotation.dart';
part 'website.g.dart';

@JsonSerializable()
class Website {
  String id;
  String name;
  String domain;
  DateTime createdAt;

  Website({
    required this.id,
    required this.name,
    required this.domain,
    required this.createdAt,
  });

  factory Website.fromJson(Map<String, dynamic> json) =>
      _$WebsiteFromJson(json);
  Map<String, dynamic> toJson() => _$WebsiteToJson(this);

  static List<Website> toList(List<dynamic> dataList) {
    List<Website> loadedWebsites = [];
    for (var website in dataList) {
      Website web = Website.fromJson(website);

      loadedWebsites.add(web);
    }
    return loadedWebsites;
  }
}

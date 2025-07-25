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

  // static List<Website> toList(List<QueryDocumentSnapshot> dataList) {
  //   List<Website> loadedMessages = [];
  //   for (var message in dataList) {
  //     Website mess = Website.fromJson(message.data() as Map<String, dynamic>);
  //     mess.id = message.id;

  //     mess.date = (message['time'] as Timestamp?)?.toDate();
  //     loadedMessages.add(mess);
  //   }
  //   return loadedMessages;
  // }
}

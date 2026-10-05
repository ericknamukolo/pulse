/// A Umami team the signed-in user is a member of.
///
/// Parsed manually (no codegen) — only [id] and [name] are needed to fetch
/// the team's websites via `/api/teams/{id}/websites`.
class Team {
  final String id;
  final String name;

  Team({required this.id, required this.name});

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'] as String,
        name: (json['name'] ?? '') as String,
      );

  static List<Team> toList(List<dynamic> dataList) =>
      dataList.map((t) => Team.fromJson(t as Map<String, dynamic>)).toList();
}

import 'package:pulse/features/websites/models/team.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class WebsiteRepo {
  static const int _pageSize = 100;

  /// Returns all websites the user can access: personal websites plus the
  /// websites of every team they belong to (Umami >= 2.5).
  ///
  /// Personal websites come from `/api/websites`; team websites require
  /// `/api/me/teams` followed by `/api/teams/{id}/websites` per team.
  /// Results are merged and de-duplicated by id. If the teams endpoints are
  /// unavailable (older self-hosted instances), personal websites are still
  /// returned instead of failing.
  Future<List<Website>> getWebsites() async {
    final websites = <Website>[];
    final seenIds = <String>{};

    final personal = await _fetchWebsitesPaged(Endpoints.websites);
    for (final website in personal) {
      if (seenIds.add(website.id)) websites.add(website);
    }

    try {
      final teams = await getTeams();
      for (final team in teams) {
        final teamWebsites =
            await _fetchWebsitesPaged(Endpoints.teamWebsites(team.id));
        for (final website in teamWebsites) {
          if (seenIds.add(website.id)) websites.add(website);
        }
      }
    } catch (e) {
      logger.w('Team websites unavailable: $e');
    }

    return websites;
  }

  /// Teams the signed-in user is a member of (`/api/me/teams`, paged).
  Future<List<Team>> getTeams() async {
    final teams = <Team>[];
    var page = 1;
    while (true) {
      final res = await Requests.get(
        endpoint: '${Endpoints.meTeams}?pageSize=$_pageSize&page=$page',
      );
      final data = (res?['data'] ?? []) as List<dynamic>;
      teams.addAll(Team.toList(data));
      final count = (res?['count'] ?? 0) as int;
      if (teams.length >= count || data.isEmpty) break;
      page++;
    }
    return teams;
  }

  Future<List<Website>> _fetchWebsitesPaged(String endpoint) async {
    final websites = <Website>[];
    var page = 1;
    while (true) {
      final res = await Requests.get(
        endpoint: '$endpoint?pageSize=$_pageSize&page=$page',
      );
      final data = (res?['data'] ?? []) as List<dynamic>;
      websites.addAll(Website.toList(data));
      final count = (res?['count'] ?? 0) as int;
      if (websites.length >= count || data.isEmpty) break;
      page++;
    }
    return websites;
  }

  Future<void> addWebsite(
      {required String name, required String domain}) async {
    await Requests.post(
      endpoint: Endpoints.websites,
      body: {
        'name': name.trim(),
        'domain': domain.trim(),
      },
    );
  }

  Future<void> editWebsite(
      {required String name,
      required String domain,
      required String id}) async {
    await Requests.post(
      endpoint: '${Endpoints.websites}/$id',
      body: {
        'name': name.trim(),
        'domain': domain.trim(),
      },
    );
  }

  Future<void> deleteWebsite({required String id}) async {
    var res = await Requests.delete(endpoint: '${Endpoints.websites}/$id');
    logger.i(res);
  }
}

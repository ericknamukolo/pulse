import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class WebsiteRepo {
  Future<List<Website>> getWebsites() async {
    var res = await Requests.get(endpoint: '${Endpoints.websites}?pageSize=20');
    logger.i(res);
    return Website.toList(res?['data'] ?? []);
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

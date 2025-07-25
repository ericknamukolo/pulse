import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class WebsiteRepo {
  Future<List<Website>> getWebsites() async {
    var res = await Requests.get(endpoint: Endpoints.websites);

    return Website.toList(res?['data'] ?? []);
  }

  Future<void> addWebsite(
      {required String name, required String domain}) async {
    var res = await Requests.post(
      endpoint: Endpoints.websites,
      body: {
        'name': name.trim(),
        'domain': domain.trim(),
      },
    );
    logger.i(res);
  }
}

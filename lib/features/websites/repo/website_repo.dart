import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/requests.dart';

class WebsiteRepo {
  Future<List<Website>> getWebsites() async {
    var res = await Requests.get(endpoint: Endpoints.websites);

    return Website.toList(res?['data'] ?? []);
  }
}

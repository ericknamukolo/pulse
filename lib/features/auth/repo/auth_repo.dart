import 'dart:convert';

import 'package:pulse/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  signIn() async {
    try {
      var res = await http.post(
        Uri.parse('https://cloud.umami.is/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      logger.i(res.statusCode);
      logger.i(res.body);
      logger.i(res.reasonPhrase);

      logger.i('SignIn Response: ${res.body}');
    } catch (e) {
      logger.e(e);
    }
  }
}

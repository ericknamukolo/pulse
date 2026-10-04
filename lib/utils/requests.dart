import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pulse/features/auth/repo/auth_repo.dart';
import 'package:pulse/utils/utils.dart';

import 'local_storage.dart';

enum RequestType { get, post, delete, put, patch }

const cloudSessionCookie = '__Secure-umami.session_token';

class Requests {
  static Map<String, String> noAuthHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Umami Cloud authenticates with a session cookie, self-hosted with a JWT.
  static Map<String, String> get authHeaders {
    final token = prefs.getString(LocalStorage.jwt) ?? '';
    return {
      ...noAuthHeaders,
      if (token.startsWith(cloudSessionCookie))
        'Cookie': token
      else
        'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>?> post({
    required String endpoint,
    int okStatusCode = 200,
    Map<String, dynamic> body = const {},
    bool noAuth = false,
    void Function(http.Response res)? onResponse,
  }) async {
    return await requestWrapper(
      onResponse: onResponse,
      fn: http.post(Uri.parse(endpoint),
          body: json.encode(body),
          headers: noAuth ? noAuthHeaders : authHeaders),
      okStatusCode: okStatusCode,
      endpoint: endpoint,
      reqestType: RequestType.post,
      body: body,
    );
  }

  static Future<Map<String, dynamic>?> put({
    required String endpoint,
    int okStatusCode = 200,
    Map<String, dynamic>? body,
    bool noAuth = false,
  }) async {
    return await requestWrapper(
      fn: http.put(Uri.parse(endpoint),
          body: json.encode(body),
          headers: noAuth ? noAuthHeaders : authHeaders),
      okStatusCode: okStatusCode,
      endpoint: endpoint,
      reqestType: RequestType.put,
      body: body,
    );
  }

  static Future<Map<String, dynamic>?> patch({
    required String endpoint,
    int okStatusCode = 200,
    Map<String, dynamic>? body,
    bool noAuth = false,
  }) async {
    return await requestWrapper(
      fn: http.patch(Uri.parse(endpoint),
          body: json.encode(body),
          headers: noAuth ? noAuthHeaders : authHeaders),
      okStatusCode: okStatusCode,
      endpoint: endpoint,
      reqestType: RequestType.patch,
      body: body,
    );
  }

  static Future<dynamic> get({
    required String endpoint,
    int okStatusCode = 200,
    bool useKey = false,
  }) async {
    return await requestWrapper(
      fn: http.get(Uri.parse(endpoint),
          headers: useKey
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'x-umami-api-key': '${dotenv.env['API_KEY']}'
                }
              : authHeaders),
      okStatusCode: okStatusCode,
      endpoint: endpoint,
      reqestType: RequestType.get,
    );
  }

  static Future<Map<String, dynamic>?> delete({
    required String endpoint,
    int okStatusCode = 200,
    Map<String, dynamic>? body,
    bool noAuth = false,
  }) async {
    return await requestWrapper(
      fn: http.delete(Uri.parse(endpoint),
          body: json.encode(body), headers: authHeaders),
      okStatusCode: okStatusCode,
      endpoint: endpoint,
      reqestType: RequestType.delete,
      body: body,
    );
  }

  static Future<dynamic> requestWrapper({
    required Future<http.Response> fn,
    required int okStatusCode,
    required String endpoint,
    required RequestType reqestType,
    Map<String, dynamic>? body,
    void Function(http.Response res)? onResponse,
  }) async {
    try {
      http.Response res;
      res = await fn.timeout(const Duration(seconds: 10));
      final isLogin =
          endpoint.contains('auth/login') || endpoint.contains('auth/sign-in');

      if (isLogin && res.statusCode == 404) {
        return throw Exception('Invalid host url');
      }

      if (res.statusCode == 401 && !isLogin) {
        await AuthRepo.tokenExpired();
        return null;
      }

      if (res.statusCode != okStatusCode) {
        final err = json.decode(res.body);
        return throw Exception(
            err?['error'] ?? err?['message'] ?? 'Error occurred');
      }
      onResponse?.call(res);
      return json.decode(res.body);
    } on TimeoutException {
      throw TimeoutException('Requests taking too long');
    } on SocketException {
      throw SocketException('No network');
    } on http.ClientException {
      throw Exception('An unexpected error occurred while making the request.');
    } catch (e) {
      rethrow;
    }
  }
}

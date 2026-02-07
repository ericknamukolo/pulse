import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pulse/features/auth/repo/auth_repo.dart';
import 'package:pulse/utils/utils.dart';

import 'local_storage.dart';

enum RequestType { get, post, delete, put, patch }

class Requests {
  static Map<String, String> noAuthHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Map<String, dynamic>?> post({
    required String endpoint,
    int okStatusCode = 200,
    Map<String, dynamic> body = const {},
    bool noAuth = false,
  }) async {
    return await requestWrapper(
      fn: http.post(Uri.parse(endpoint),
          body: json.encode(body),
          headers: noAuth
              ? noAuthHeaders
              : {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${prefs.getString(LocalStorage.jwt)}'
                }),
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
          headers: noAuth
              ? noAuthHeaders
              : {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${prefs.getString(LocalStorage.jwt)}'
                }),
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
          headers: noAuth
              ? noAuthHeaders
              : {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${prefs.getString(LocalStorage.jwt)}'
                }),
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
              : {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${prefs.getString(LocalStorage.jwt)}'
                }),
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
      fn: http.delete(Uri.parse(endpoint), body: json.encode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString(LocalStorage.jwt)}'
      }),
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
  }) async {
    try {
      http.Response res;
      res = await fn.timeout(const Duration(seconds: 10));

      if (endpoint.contains('auth/login') && res.statusCode == 404) {
        return throw Exception('Invalid host url');
      }

      if (res.statusCode == 401 && !endpoint.contains('auth/login')) {
        await AuthRepo.tokenExpired();
        return null;
      }

      if (res.statusCode != okStatusCode) {
        return throw Exception(
            json.decode(res.body)?['error'] ?? 'Error occurred');
      }
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

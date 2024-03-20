// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_bloc_app/api/api_error.dart';

class Api {
  static const ENDPOINT = 'newsapi.org';
  static const APIKEY = '1c042c9709c4401ba2770cc2a3d9325e';
  static const API_VERSION = 'v2';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-api-key': Api.APIKEY
  };

  Future<dynamic> get(String method, {Map<String, dynamic>? params}) async {
    Uri url = Uri.https(ENDPOINT, "$API_VERSION/$method", params);
    http.Response response = await http.get(url, headers: _headers);
    Map<String, dynamic> content = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ApiError(response.statusCode, content.toString());
    }
    return content;
  }

  Future<dynamic> post(String method, {Map<String, dynamic>? params}) async {
    Uri url = Uri.https(ENDPOINT, "$API_VERSION/$method");
    http.Response response =
        await http.post(url, body: params, headers: _headers);
    Map<String, dynamic> content = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ApiError(response.statusCode, content.toString());
    }
    return content;
  }
}

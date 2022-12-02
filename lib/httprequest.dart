import 'dart:convert';

import 'package:logger/logger.dart';

import 'ServerInfo.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  Future<http.Response> sendGetRequest(String addr, Map<String, String>? params) async {
    String uri = ServerInfo.addr+addr;
    int no_ampersand = 1;
    if (params != null) {
      uri += '?';
    }
    params?.forEach((key, value) {
      String segment = "";
      //처음 빼고 & 추가
      if(no_ampersand == 1){
        segment += '&';
        no_ampersand = 0;
      }
      segment += key;
      segment += '=';
      segment += value;

      //결과 합체
      uri += segment;
    });

    http.Response response = await http.get(Uri.parse(uri));
    return response;

  }
  Future<http.Response> sendPostRequest(String addr,Map<String, dynamic>? params)  async {
    String uri = ServerInfo.addr+addr;
    Logger().v(jsonEncode(params));
    http.Response response = await http.post(Uri.parse(uri),headers:
    {"Content-Type" : "application/json"},
    body: jsonEncode(params));
    return response;

  }

}
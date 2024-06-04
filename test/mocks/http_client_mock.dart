
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HttpClientMock implements http.Client {

  final Map<String, dynamic> _responseMap;

  HttpClientMock(this._responseMap);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final responseJson = _responseMap[url.toString()];
    if (responseJson != null) {
      final jsonString = await rootBundle.loadString(responseJson);
      dynamic jsonData = jsonDecode(jsonString);
      final string = json.encode(jsonData);
      return Future.value(http.Response(string, 200));
    } else {
      return Future.value(http.Response('Not Found', 404));
    }
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }

  @override
  void close() { }
}
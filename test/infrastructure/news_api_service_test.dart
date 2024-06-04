
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/extensions/http_overrides_extension.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';

import '../mocks/http_client_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("News api services get success", () async {
    final mockResponses = {
    '${NewsApiService.baseUrl}/top-headlines?country=us&apiKey=${NewsApiService.apiKey}': 'assets/mocks/data.json'
    };
    final httpClientMock = HttpClientMock(mockResponses);
    final newsApiService = NewsApiService(httpClientMock);
    final result = await newsApiService.fetchTopHeadlines();
    expect(result, isA<List<NewsModel>>());
    expect(result.length, 1);

    HttpOverrides.global = HttpOverridesExtension();
    final context = SecurityContext.defaultContext;
    HttpClient httpClient = HttpOverrides.current!.createHttpClient(context);
    expect(httpClient, isNotNull);
    expect(HttpOverrides.current, isA<HttpOverridesExtension>());
  });
}
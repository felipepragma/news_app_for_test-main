import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/extensions/http_overrides_extension.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';

import '../mocks/http_client_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Test get news api services ", () {
    final mockResponses = {
      '${NewsApiService.baseUrl}/top-headlines?country=us&apiKey=${NewsApiService.apiKey}':
          'assets/mocks/data.json'
    };

    late final HttpClientMock httpClientMock;
    late final NewsApiService newsApiService;

    setUpAll(() {
      httpClientMock = HttpClientMock(mockResponses);
      newsApiService = NewsApiService(httpClientMock);
    });

    test("success check instace of List<NewsEntity>", () async {
      // Arrange
      final result = await newsApiService.fetchTopHeadlines();

      // Assert
      expect(result, isA<List<NewsModel>>());
    });

    test("success check length list", () async {
      // Arrange
      final result = await newsApiService.fetchTopHeadlines();

      // Assert
      expect(result.length, 1);
    });
  });
}

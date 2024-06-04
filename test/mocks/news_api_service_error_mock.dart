import 'package:http/http.dart' as http;
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';

class NewsApiServiceErrorMock implements NewsApiService {
  @override
  http.Client? client;
  
  @override
  Future<List<NewsModel>> fetchTopHeadlines() async {
    throw UnsupportedError("Error call news");
  }
}
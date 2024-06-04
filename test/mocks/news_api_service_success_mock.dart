import 'package:http/http.dart' as http;
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';

class NewsApiServiceSuccessMock implements NewsApiService {

  @override
  http.Client? client;

  @override
  Future<List<NewsModel>> fetchTopHeadlines() async {
    final listNews = List<NewsModel>.generate(10, (index) => NewsModel(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName"));
    return Future.value(listNews);
  }
}
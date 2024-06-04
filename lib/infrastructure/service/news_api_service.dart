import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_for_test/infrastructure/extensions/http_overrides_extension.dart';
import 'dart:io';
import '../models/news_model.dart';

class NewsApiService {
  static const String apiKey = 'e314395b2db24dca8f827e2b44c73cf6';
  static const String baseUrl = 'https://newsapi.org/v2';
  http.Client? client;

  NewsApiService([this.client]);

  Future<List<NewsModel>> fetchTopHeadlines() async {
    HttpOverrides.global = HttpOverridesExtension();
    final httpClient = client ?? http.Client();
    final response = await httpClient
        .get(Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      final news = articles.map((json) => NewsModel.fromJson(json)).toList();
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}

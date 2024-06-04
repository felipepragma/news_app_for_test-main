
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';

void main() {
  test("Test news model fromJson", () {
    final Map<String, dynamic> mapJson = {
      "title": "title",
      "description": "description",
      "url": "url",
      "urlToImage": "urlToImage",
      "source": {
        "name": "name"
      }
    };
    final newsModel = NewsModel.fromJson(mapJson);
    expect(newsModel.title, "title");
    expect(newsModel.description, "description");
    expect(newsModel.url, "url");
    expect(newsModel.urlToImage, "urlToImage");
    final mapNewsModel = newsModel.toJson();
    expect(mapNewsModel['title'], mapJson["title"]);
    expect(mapNewsModel['description'], mapJson["description"]);
    expect(mapNewsModel["url"], mapJson["url"]);
    expect(mapNewsModel["urlToImage"], mapJson["urlToImage"]);
  });
}
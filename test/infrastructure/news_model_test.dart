import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';

void main() {
  group("Test news model", () {

    final Map<String, dynamic> mapJson = {
      "title": "title",
      "description": "description",
      "url": "url",
      "urlToImage": "urlToImage",
      "source": {"name": "name"}
    };
    
    late final NewsModel newsModel;

    setUpAll(() {
      newsModel = NewsModel.fromJson(mapJson);
    });

    test("model fromJson", () {
      // Assert
      expect(newsModel.title, "title");
      expect(newsModel.description, "description");
      expect(newsModel.url, "url");
      expect(newsModel.urlToImage, "urlToImage");
    });

    test("model toJson", () {
      // Arrange
      final mapNewsModel = newsModel.toJson();

      // Assert
      expect(mapNewsModel['title'], mapJson["title"]);
      expect(mapNewsModel['description'], mapJson["description"]);
      expect(mapNewsModel["url"], mapJson["url"]);
      expect(mapNewsModel["urlToImage"], mapJson["urlToImage"]);
    });
  });
}

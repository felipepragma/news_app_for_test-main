import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/ui/screens/news_search_screen.dart';

void main() {
  testWidgets("Test search delegate lenght", (tester) async {
    final listNews = List<NewsEntity>.generate(
        10,
        (index) => NewsEntity(
            title: "title",
            description: "description",
            url: "url",
            urlToImage: "",
            sourceName: "sourceName"));
    final searchScreen = NewsSearchScreen(listNews);
    expect(searchScreen.newsList.length, 10);
  });

  group("Test search delegate widget", () {
    final listNews = List<NewsEntity>.generate(
        10,
        (index) => NewsEntity(
            title: "title",
            description: "description",
            url: "url",
            urlToImage: "",
            sourceName: "sourceName"));

    late Widget searchDelegateWidget;

    setUp(() {
      searchDelegateWidget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: NewsSearchScreen(listNews));
                },
              );
            },
          ),
        ),
      );
    });

    testWidgets('Tap search button and open search list', (tester) async {
      // Arrange
      await tester.pumpWidget(searchDelegateWidget);

      // Act
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final appBarFinder = find.byType(AppBar);
      final textFieldFinder = find.byType(TextField);

      // Assert
      expect(appBarFinder, findsOneWidget);
      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets('Search delegate test', (tester) async {
      // Arrange
      await tester.pumpWidget(searchDelegateWidget);

      // Act
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final firstItem = find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(ListTile),
          )
          .first;

      // Assert
      expect(firstItem, findsOneWidget);
      await tester.tap(firstItem);
      await tester.pumpAndSettle();
    });

    testWidgets('Search word in text field', (tester) async {
      // Arrange
      await tester.pumpWidget(searchDelegateWidget);

      // Act
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'Ti');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Ti'), findsOneWidget);
    });

    testWidgets('Clear word in text field', (tester) async {
      // Arrange
      await tester.pumpWidget(searchDelegateWidget);

      // Act
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'Ti');
      await tester.pumpAndSettle();
      final clearButton = find.byIcon(Icons.clear);
      await tester.tap(clearButton);

      // Assert
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('Search delegate back', (tester) async {
      // Arrange
      await tester.pumpWidget(searchDelegateWidget);

      // Act
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);

      // Assert
      expect(find.byType(IconButton).first, findsOneWidget);
    });
  });
}

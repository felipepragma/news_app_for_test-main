
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/ui/screens/news_search_screen.dart';

void main() {
  testWidgets("Search delegate", (tester) async {
    final listNews = List<NewsEntity>.generate(10, (index) => NewsEntity(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName"));
    final searchScreen = NewsSearchScreen(listNews);
    expect(searchScreen.newsList.length, 10);
  });

  testWidgets('Search delegate test', (tester) async {
    final listNews = List<NewsEntity>.generate(10, (index) => NewsEntity(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName"));
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NewsSearchScreen(listNews));
              },
            );
          },
        ),
      ),
    ));
    
    final searchButton = find.byType(IconButton);

    await tester.tap(searchButton);
    await tester.pumpAndSettle();
    
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);
    final textFieldFinder = find.byType(TextField);
   
    expect(textFieldFinder, findsOneWidget);
    
    final firstItem = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(ListTile),
    ).first;

    expect(firstItem, findsOneWidget);

    await tester.tap(firstItem);
    await tester.pumpAndSettle();
  });

  testWidgets('Search delegate test clear', (tester) async {
    final listNews = List<NewsEntity>.generate(10, (index) => NewsEntity(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName"));
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NewsSearchScreen(listNews));
              },
            );
          },
        ),
      ),
    ));
    
    final searchButton = find.byType(IconButton);

    await tester.tap(searchButton);
    await tester.pumpAndSettle();
    
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);
    final textFieldFinder = find.byType(TextField);
   
    expect(textFieldFinder, findsOneWidget);
    
    await tester.enterText(textFieldFinder, 'Ti');
    await tester.pumpAndSettle();
    
    expect(find.text('Ti'), findsOneWidget);

    final clearButton = find.byIcon(Icons.clear);
    await tester.tap(clearButton);
    expect(find.text(''), findsOneWidget);
  });

  testWidgets('Search delegate test back', (tester) async {
    final listNews = List<NewsEntity>.generate(10, (index) => NewsEntity(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName"));
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NewsSearchScreen(listNews));
              },
            );
          },
        ),
      ),
    ));
    
    final searchButton = find.byType(IconButton);

    await tester.tap(searchButton);
    await tester.pumpAndSettle();
    
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);
    final textFieldFinder = find.byType(TextField);
   
    expect(textFieldFinder, findsOneWidget);
    
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
  });
}
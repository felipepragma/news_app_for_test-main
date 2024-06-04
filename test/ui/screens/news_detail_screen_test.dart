
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/ui/screens/news_detail_screen.dart';

void main() {
  testWidgets("Test news detail screen", (tester) async {
    final entity = NewsEntity(title: "title", description: "description", url: "url", urlToImage: "", sourceName: "sourceName");
    await tester.pumpWidget(MaterialApp(
        home: NewsDetailScreen(news: entity),
      )
    );
    await tester.pumpAndSettle();

    expect(find.text('title').first, findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.byElementType(Image), findsNothing);
  });
}
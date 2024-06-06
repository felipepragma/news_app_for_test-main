import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';
import 'package:provider/provider.dart';

import '../../mocks/news_api_service_success_mock.dart';

void main() {
  group("Test news list screen", () {
    late Widget listScreen;

    setUp(() {
      listScreen = MultiProvider(
        providers: [
          Provider(create: (_) => NewsApiServiceSuccessMock()),
          ProxyProvider<NewsApiServiceSuccessMock, GetNewsUsecase>(
            update: (_, apiService, __) => GetNewsUsecase(apiService),
          ),
        ],
        child: const MaterialApp(
          home: NewsListScreen(),
        ),
      );
    });

    testWidgets("Find list screen widget", (tester) async {
      // Arrange
      await tester.pumpWidget(listScreen);

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('News'), findsOneWidget);
    });

    testWidgets("Find one item list", (tester) async {
      // Arrange
      await tester.pumpWidget(listScreen);

      // Act
      await tester.pumpAndSettle();
      final firstItem = find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(NewsCardWidget),
          )
          .first;

      // Assert
      expect(firstItem, findsOneWidget);
    });

    testWidgets("Tap search button list screen", (tester) async {
      // Arrange
      await tester.pumpWidget(listScreen);

      // Act
      await tester.pumpAndSettle();
      final searchButton = find.byType(IconButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final appBarFinder = find.byType(AppBar);
      final textFieldFinder = find.byType(TextField);

      // Assert
      expect(appBarFinder, findsOneWidget);
      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets("Find item in search list screen", (tester) async {
      // Arrange
      await tester.pumpWidget(listScreen);

      // Act
      await tester.pumpAndSettle();
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
  });
}


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';
import 'package:provider/provider.dart';

import '../../mocks/news_api_service_success_mock.dart';

void main() {
 testWidgets("Test new list screen", (tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider(create: (_) => NewsApiServiceSuccessMock()),
        ProxyProvider<NewsApiServiceSuccessMock, GetNewsUsecase>(
          update: (_, apiService, __) => GetNewsUsecase(apiService),
        ),
      ],
      child: const MaterialApp(
        home: NewsListScreen(),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('News'), findsOneWidget);

    final firstItem = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(NewsCardWidget),
    ).first;

    expect(firstItem, findsOneWidget);
  }); 

  testWidgets("Test search new list screen", (tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider(create: (_) => NewsApiServiceSuccessMock()),
        ProxyProvider<NewsApiServiceSuccessMock, GetNewsUsecase>(
          update: (_, apiService, __) => GetNewsUsecase(apiService),
        ),
      ],
      child: const MaterialApp(
        home: NewsListScreen(),
      ),
    ));

    await tester.pumpAndSettle();

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
}
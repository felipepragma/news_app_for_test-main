import 'package:flutter/material.dart';
import 'package:news_app_for_test/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("News open app, search news list", (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(NewsListScreen), findsOneWidget);

    final searchButton = find.byType(IconButton);

    await tester.tap(searchButton);

    await tester.pumpAndSettle();
    
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);
    final textFieldFinder = find.byType(TextField);
   
    expect(textFieldFinder, findsOneWidget);
    
    await tester.enterText(textFieldFinder, 'Ti');
    await tester.pumpAndSettle();

    await tester.enterText(textFieldFinder, '');
    await tester.pumpAndSettle();

    final firstItem = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(ListTile),
    ).first;

    expect(firstItem, findsOneWidget);

    await tester.tap(firstItem);

  });
}
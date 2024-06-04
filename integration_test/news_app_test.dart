import 'package:news_app_for_test/main.dart' as app;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app_for_test/ui/screens/news_detail_screen.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("News open app, select firts card and show detail", (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(NewsListScreen), findsOneWidget);

    final firstItem = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(NewsCardWidget),
    ).first;

    await tester.tap(firstItem);

    await tester.pumpAndSettle();

    expect(find.byType(NewsDetailScreen), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.pageBack();

    await tester.pumpAndSettle();

    expect(find.byType(NewsListScreen), findsOneWidget);
  });
}
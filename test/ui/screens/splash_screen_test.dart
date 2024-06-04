import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../mocks/news_api_service_success_mock.dart';

void main() {
  testWidgets("Test splash screen", (tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider(create: (_) => NewsApiServiceSuccessMock()),
        ProxyProvider<NewsApiServiceSuccessMock, GetNewsUsecase>(
          update: (_, apiService, __) => GetNewsUsecase(apiService),
        ),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    ));
    expect(find.text('News App'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('News App'), findsNothing);
  });
}

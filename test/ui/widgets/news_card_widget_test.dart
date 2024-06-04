import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';

void main() {
  testWidgets("Create news card widget - not image and on tap", (tester) async {
    bool onTapCalled = false;
    await tester.pumpWidget(MaterialApp(
      home: NewsCardWidget(
          imagePath: "",
          source: "Source",
          title: "Title",
          onTap: () {
            onTapCalled = true;
          }),
    ));
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Source'), findsOneWidget);
    final gestureDetector = find.byType(GestureDetector);
    await tester.tap(gestureDetector);
    await tester.pump();
    expect(onTapCalled, true);
  });

  testWidgets("Create news card widget - with image and on tap", (tester) async {
    bool onTapCalled = false;

     await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
      home: NewsCardWidget(
          imagePath: "https://dims.apnews.com/dims4/default/8c8fd0c/2147483647/strip/true/crop/8055x4531+0+0/resize/1440x810!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2Fe9%2Fe7%2F1fff08bb4ad8a017fcddd4e8146b%2Fap24154548553643.jpg",
          source: "Source",
          title: "Title",
          onTap: () {
            onTapCalled = true;
          }),
    )));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Source'), findsOneWidget);
    expect(find.byType(Container).last, findsOneWidget);
    final gestureDetector = find.byType(GestureDetector);

    await tester.tap(gestureDetector);
    await tester.pump();
    expect(onTapCalled, true);
  });
}

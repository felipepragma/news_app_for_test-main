import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';

void main() {
  group("Test news card widget", () {
    late Widget cardWidget;
    bool onTapCalled = false;

    setUpAll(() {
      cardWidget = MaterialApp(
        home: NewsCardWidget(
            imagePath: "",
            source: "Source",
            title: "Title",
            onTap: () {
              onTapCalled = true;
            }),
      );
    });

    testWidgets("Show title and source", (tester) async {
      // Arrange
      await tester.pumpWidget(cardWidget);

      // Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Source'), findsOneWidget);
    });

    testWidgets("On tap card", (tester) async {
      // Arrange
      await tester.pumpWidget(cardWidget);

      // Act
      final gestureDetector = find.byType(GestureDetector);
      await tester.tap(gestureDetector);
      await tester.pump();

      //Assert
      expect(onTapCalled, true);
    });
  });

  testWidgets("Load image card", (tester) async {
    // Arrange
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: NewsCardWidget(
              imagePath:
                  "https://dims.apnews.com/dims4/default/8c8fd0c/2147483647/strip/true/crop/8055x4531+0+0/resize/1440x810!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2Fe9%2Fe7%2F1fff08bb4ad8a017fcddd4e8146b%2Fap24154548553643.jpg",
              source: "Source",
              title: "Title",
              onTap: () {}),
        )));

    // Act
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Assert
    expect(find.byType(Container).last, findsOneWidget);
  });
}

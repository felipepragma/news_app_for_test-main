
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/extensions/http_overrides_extension.dart';

void main() {
  
group("Test http overrides", () {

  setUpAll(() {
    HttpOverrides.global = HttpOverridesExtension();  
  });

  test("Test http client is not null", () {
    // Arrange
    final context = SecurityContext.defaultContext;

    // Act
    HttpClient httpClient = HttpOverrides.current!.createHttpClient(context);

    // Assert
    expect(httpClient, isNotNull);
  });

  test("Test current overrides is HttpOverridesExtension", () {
    // Assert
    expect(HttpOverrides.current, isA<HttpOverridesExtension>());
  });
 });
}
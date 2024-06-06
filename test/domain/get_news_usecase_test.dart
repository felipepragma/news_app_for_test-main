import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import '../mocks/news_api_service_error_mock.dart';
import '../mocks/news_api_service_success_mock.dart';

void main() {
  group("Test get news usecase", () {

    late final NewsApiServiceSuccessMock newsApiServiceMock;
    late final GetNewsUsecase getNewsUseCase;

    setUpAll(() {
      newsApiServiceMock = NewsApiServiceSuccessMock();
      getNewsUseCase = GetNewsUsecase(newsApiServiceMock);
    });

    test("success check instace of List<NewsEntity>",
        () async {
      // Act
      final result = await getNewsUseCase.execute();

      // Assert
      expect(result, isA<List<NewsEntity>>());
    });

    test("success check length of list", () async {
      // Act
      final result = await getNewsUseCase.execute();

      // Assert
      expect(result.length, 10);
    });
  });

  test("Test get news usecase error", () async {
    // Arrange
    final newsApiServiceMock = NewsApiServiceErrorMock();
    final getNewsUseCase = GetNewsUsecase(newsApiServiceMock);

    // Assert
    expect(() => getNewsUseCase.execute(), throwsA(isUnsupportedError));
  });
}

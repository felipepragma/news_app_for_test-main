import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import '../mocks/news_api_service_error_mock.dart';
import '../mocks/news_api_service_success_mock.dart';

void main() {

 test("Test get news usecase success", () async {
  final newsApiServiceMock = NewsApiServiceSuccessMock();
  final getNewsUseCase = GetNewsUsecase(newsApiServiceMock);
  final result = await getNewsUseCase.execute();
  expect(result, isA<List<NewsEntity>>());
  expect(result.length, 10);
 });

 test("Test get news usecase error", () async {
  final newsApiServiceMock = NewsApiServiceErrorMock();
  final getNewsUseCase = GetNewsUsecase(newsApiServiceMock);
  expect(() => getNewsUseCase.execute(), throwsA(isUnsupportedError));
 });
}

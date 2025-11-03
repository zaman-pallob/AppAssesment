// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app_assesment/features/product/data/models/product_model.dart';
import 'package:app_assesment/features/product/domain/entities/products_info.dart';
import 'package:app_assesment/features/product/domain/repositories/product_repository.dart';
import 'package:app_assesment/features/product/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProducts usecase;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    //we are injecting mock repository to usecase so that it uses the mock data and not the real one
    usecase = GetProducts(mockRepo);
  });

  // Added test for GetProducts usecase
  test('Get Products', () async {
    final model = ProductModel(
      id: 1,
      title: 't',
      description: 'd',
      price: 10,
      thumbnail: 'thumb',
    );
    final info = ProductsInfo(
      productList: [model],
      hasMore: false,
      isOnline: true,
    );
    // we are setting the expected behavior of the mock repository
    when(
      () => mockRepo.getProducts(skip: 0, limit: 16, forceRefresh: false),
    ).thenAnswer((_) async => Right(info));

    //then we call the usecase to test the behavior
    final result = await usecase.call(skip: 0, limit: 16);

    //if the result is right then we expect the product list to be not empty
    expect(result.isRight(), true);
    result.match(
      (left) => fail('expected right'),
      (right) => expect(right.productList, isNotEmpty),
    );
    //verify that the mock repository method was called once during the test as multipe calls would indicate an issue
    verify(
      () => mockRepo.getProducts(skip: 0, limit: 16, forceRefresh: false),
    ).called(1);
  });
}

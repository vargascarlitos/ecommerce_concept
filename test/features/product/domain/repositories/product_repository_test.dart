import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

import 'package:ecommerce_concept/features/product/data/datasource/product_remote_datasource.dart';
import 'package:ecommerce_concept/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/app_config/error/failure.dart';
import 'package:ecommerce_concept/features/product/data/models/product_list_response_model.dart';

@GenerateMocks([ProductRemoteDataSource])
import 'product_repository_test.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockRemoteDataSource;
  late ProductRepository repository;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository =
        ProductRepositoryImpl(productRemoteDataSource: mockRemoteDataSource);
  });

  group('ProductRepositoryImpl', () {
    const limit = 2;
    const skip = 0;

    final mockResponseModel = ProductListResponseModel.fromJson(
      TestHelper.productListResponseModel,
    );

    test(
        'should return a list of ProductEntity when the remote call is successful',
        () async {
      // Arrange
      when(
        mockRemoteDataSource.fetchProducts(
          limit: limit,
          skip: skip,
        ),
      ).thenAnswer(
        (_) async => Result.value(mockResponseModel),
      );

      // Act
      final result = await repository.getProducts(limit: limit, skip: skip);

      // Assert
      expect(result, isA<ValueResult<List<ProductEntity>>>());
      expect((result as ValueResult).value, isNotEmpty);
      expect(
          result.asValue?.value.first.title, 'Essence Mascara Lash Princess');
    });

    test('should return ServerFailure when the remote call is unsuccessful',
        () async {
      // Arrange
      when(mockRemoteDataSource.fetchProducts(limit: limit, skip: skip))
          .thenAnswer(
        (_) async => Result.error(
          Exception('Failed to fetch'),
        ),
      );

      // Act
      final result = await repository.getProducts(limit: limit, skip: skip);

      // Assert
      expect(result, isA<ErrorResult>());
      expect((result as ErrorResult).error, isA<ServerFailure>());
      expect(
        (result.error as ServerFailure).message,
        contains('Failed to fetch'),
      );
    });
  });
}

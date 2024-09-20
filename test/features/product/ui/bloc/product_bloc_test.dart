import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_concept/app_config/error/failure.dart';

// Genera los mocks necesarios
@GenerateMocks([ProductRepository])
import 'product_bloc_test.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late ProductBloc productBloc;

  setUp(() {
    mockProductRepository = MockProductRepository();
    productBloc = ProductBloc(productRepository: mockProductRepository);
  });

  tearDown(() {
    productBloc.close();
  });

  const mockProduct = TestHelper.productEntity;

  group('ProductBloc', () {
    blocTest<ProductBloc, ProductState>(
      'emit [success] when products are fetched successfully',
      build: () {
        when(mockProductRepository.getProducts(
                skip: anyNamed('skip'), limit: anyNamed('limit')))
            .thenAnswer((_) async => Result.value([mockProduct]));
        return productBloc;
      },
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        ProductState(
          status: ProductStatus.success,
          products: const [mockProduct],
          hasReachedMax: false,
          skip: mockProduct.id,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emit [failure] when fetching products fails',
      build: () {
        when(mockProductRepository.getProducts(
                skip: anyNamed('skip'), limit: anyNamed('limit')))
            .thenAnswer((_) async =>
                Result.error(const ServerFailure('Failed to fetch products')));
        return productBloc;
      },
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(
          status: ProductStatus.failure,
          failure: ServerFailure('Failed to fetch products'),
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'does not fetch more products when hasReachedMax is true',
      build: () {
        when(mockProductRepository.getProducts(
                skip: 0, limit: 1))
            .thenAnswer((_) async => Result.value([]));
        return productBloc;
      },
      seed: () => const ProductState(
        status: ProductStatus.success,
        products: [mockProduct],
        hasReachedMax: true,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => <ProductState>[],
    );
  });
}

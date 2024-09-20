import 'package:ecommerce_concept/app_config/http_client/api_client.dart';
import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/data/datasource/product_remote_datasource.dart';
import 'package:ecommerce_concept/features/product/data/models/product_list_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

@GenerateMocks([APIClient])
import 'product_remote_datasource_test.mocks.dart';

void main() {
  late MockAPIClient mockApiClient;
  late ProductRemoteDataSource dataSource;

  setUp(() {
    mockApiClient = MockAPIClient();
    dataSource = ProductRemoteDatasourceImpl(apiClient: mockApiClient);
  });

  group('ProductRemoteDataSource', () {
    const limit = 2;
    const skip = 0;
    const url = '/products';

    test('should return ProductListResponseModel when API call is successful',
        () async {
      // Arrange
      when(mockApiClient.getRequest<ProductListResponseModel>(
        url,
        queryParameters: anyNamed('queryParameters'),
        converter: anyNamed('converter'),
      )).thenAnswer(
        (_) async => Result.value(
          ProductListResponseModel.fromJson(
            TestHelper.productListResponseModel,
          ),
        ),
      );

      // Act
      final result = await dataSource.fetchProducts(limit: limit, skip: skip);

      // Assert
      expect(result, isA<ValueResult<ProductListResponseModel>>());
      expect((result as ValueResult).value.products.length, 2);
      expect(result.asValue?.value.products?.first.title,
          'Essence Mascara Lash Princess');
    });

    test('should return an error Result when API call fails', () async {
      // Arrange
      when(mockApiClient.getRequest(
        any,
        queryParameters: anyNamed('queryParameters'),
        converter: anyNamed('converter'),
      )).thenThrow(Exception('Failed'));

      // Act
      final result = await dataSource.fetchProducts(limit: limit, skip: skip);

      // Assert
      expect(result, isA<ErrorResult>());
      expect((result as ErrorResult).error, isA<Exception>());
      expect(result.error.toString(), contains('Failed'));
    });
  });
}

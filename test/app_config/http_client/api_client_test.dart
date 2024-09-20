import 'package:dio/dio.dart';
import 'package:ecommerce_concept/app_config/http_client/api_client_impl.dart';
import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/data/models/product_list_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

// Genera los mocks necesarios
@GenerateMocks([Dio])
import 'api_client_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late ApiClientImpl apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClientImpl(dio: mockDio);
  });

  group(
    'ApiClientImpl tests',
    () {
      const url = 'https://dummyjson.com/products';

      test(
          'should return ProductListResponseModel when the request is successful',
          () async {
        // Arrange
        when(mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
              data: TestHelper.productListResponseModel,
              statusCode: 200,
              requestOptions: RequestOptions(path: url),
            ));

        // Act
        final result = await apiClient.getRequest<ProductListResponseModel>(
          url,
          converter: (response) => ProductListResponseModel.fromJson(
            response as Map<String, dynamic>,
          ),
        );

        // Assert
        expect(result, isA<ValueResult>());
        expect(
          ((result as ValueResult).value as ProductListResponseModel),
          isA<ProductListResponseModel>(),
        );
      });

      test(
          'should return error when there is a DioException of type badResponse',
          () async {
        // Arrange
        when(mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: url),
        ));

        // Act
        final result = await apiClient.getRequest(
          url,
          converter: (response) => response,
        );

        // Assert
        expect(result, isA<ErrorResult>());
        expect(
            (result as ErrorResult).error, 'Response error, please try again');
      });

      test(
          'should return error when there is a DioException of type connectionTimeout',
          () async {
        // Arrange
        when(mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: url),
        ));

        // Act
        final result = await apiClient.getRequest(
          url,
          converter: (response) => response,
        );

        // Assert
        expect(result, isA<ErrorResult>());
        expect((result as ErrorResult).error,
            'Connection timeout, please try again');
      });

      test(
          'should return error when there is a DioException of type badCertificate',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.badCertificate,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Bad certificate, please try again');
          });

      test(
          'should return error when there is a DioException of type receiveTimeout',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.receiveTimeout,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Receive timeout, please try again');
          });

      test(
          'should return error when there is a DioException of type sendTimeout',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.sendTimeout,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Send timeout, please try again');
          });

      test(
          'should return error when there is a DioException of type cancel',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.cancel,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Request cancelled');
          });

      test(
          'should return error when there is a DioException of type unknown',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.unknown,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Internal server error, please try again');
          });

      test(
          'should return error when there is a DioException of type connectionError',
              () async {
            // Arrange
            when(mockDio.get(
              any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options'),
            )).thenThrow(DioException(
              type: DioExceptionType.connectionError,
              requestOptions: RequestOptions(path: url),
            ));

            // Act
            final result = await apiClient.getRequest(
              url,
              converter: (response) => response,
            );

            // Assert
            expect(result, isA<ErrorResult>());
            expect((result as ErrorResult).error,
                'Connection error, please try again');
          });

    },
  );
}

import 'package:async/async.dart';
import 'package:ecommerce_concept/app_config/http_client/api_client.dart';
import 'package:ecommerce_concept/features/product/data/models/product_list_response_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<Result<ProductListResponseModel>> fetchProducts({
    required int limit,
    required int skip,
  });
}

class ProductRemoteDatasourceImpl implements ProductRemoteDataSource {
  final APIClient apiClient;

  ProductRemoteDatasourceImpl({
    required this.apiClient,
  });

  @override
  Future<Result<ProductListResponseModel>> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final responseModel = await apiClient.getRequest(
        '/products',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
        converter: (json) {
          return ProductListResponseModel.fromJson(
              json as Map<String, dynamic>);
        },
      );
      return responseModel;
    } catch (e) {
      return Result.error(e);
    }
  }
}

import 'package:async/async.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts({
    required int skip,
    required int limit,
  });
}

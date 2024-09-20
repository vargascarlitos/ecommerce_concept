import 'package:async/src/result/result.dart';
import 'package:ecommerce_concept/app_config/error/failure.dart';
import 'package:ecommerce_concept/features/product/data/datasource/product_remote_datasource.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_detail_entity.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/domain/entities/review_entity.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(
      {required ProductRemoteDataSource productRemoteDataSource})
      : _productRemoteDataSource = productRemoteDataSource;

  @override
  Future<Result<List<ProductEntity>>> getProducts(
      {required int skip, required int limit}) async {
    final result = await _productRemoteDataSource.fetchProducts(
      limit: limit,
      skip: skip,
    );

    if (result.isError) {
      return Result.error(
        ServerFailure(
          result.asError!.error.toString(),
        ),
      );
    }

    final products = result.asValue!.value.products;

    List<ProductEntity> productsListEntity = products!.map((product) {
      product.images!.replaceRange(0, 1, [product.thumbnail!]);
      return ProductEntity(
        id: product.id!,
        title: product.title!,
        description: product.description!,
        price: product.price!,
        thumbnail: product.thumbnail!,
        availabilityStatus: product.availabilityStatus!,
        rating: product.rating!,
        productDetail: ProductDetailEntity(
          discountPercentage: product.discountPercentage!,
          stock: product.stock!,
          brand: product.brand ?? "",
          category: product.category!,
          images: [...product.images!],
          reviews: product.reviews!
              .map((review) => ReviewEntity(
                    date: review.date!,
                    reviewerEmail: review.reviewerEmail!,
                    rating: review.rating!,
                    comment: review.comment!,
                    reviewerName: review.reviewerName!,
                  ))
              .toList(),
        ),
      );
    }).toList();

    return Result.value(productsListEntity);
  }
}

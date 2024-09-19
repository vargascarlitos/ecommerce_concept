import 'package:async/src/result/result.dart';
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
      return Result.error(result.asError!.error);
    }

    final products = result.asValue!.value.products;

    List<ProductEntity> productsListEntity = products!
        .map(
          (product) => ProductEntity(
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
              images: product.images!.map((image) => image).toList(),
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
          ),
        )
        .toList();

    return Result.value(productsListEntity);
  }


// final ProductLocalDataSource localDataSource;
// final NetworkInfo networkInfo;
//
// ProductRepositoryImpl({
//   required this.remoteDataSource,
//   required this.localDataSource,
//   required this.networkInfo,
// });

// @override
// Future<Either<Failure, List<Product>>> getProducts() async {
//   if (await networkInfo.isConnected) {
//     try {
//       final remoteProducts = await remoteDataSource.getProducts();
//       localDataSource.cacheProducts(remoteProducts);
//       return Right(remoteProducts);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   } else {
//     try {
//       final localProducts = await localDataSource.getLastProducts();
//       return Right(localProducts);
//     } on CacheException {
//       return Left(CacheFailure());
//     }
//   }
// }
}

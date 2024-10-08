part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final int skip;
  final ServerFailure? failure;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <ProductEntity>[],
    this.hasReachedMax = false,
    this.failure,
    this.skip = 1,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    bool? hasReachedMax,
    ServerFailure? failure,
    int? skip,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure,
      skip: skip ?? this.skip,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        hasReachedMax,
        failure,
        skip,
      ];
}

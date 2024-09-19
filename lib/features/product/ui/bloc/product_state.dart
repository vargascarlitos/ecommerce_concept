part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final String errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <ProductEntity>[],
    this.hasReachedMax = false,
    this.errorMessage = '',
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        hasReachedMax,
        errorMessage,
      ];
}

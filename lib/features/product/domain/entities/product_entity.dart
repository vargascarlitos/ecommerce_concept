import 'package:ecommerce_concept/features/product/domain/entities/product_detail_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String availabilityStatus;
  final double rating;
  final ProductDetailEntity productDetail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.availabilityStatus,
    required this.rating,
    required this.productDetail,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
    String? availabilityStatus,
    double? rating,
    ProductDetailEntity? productDetail,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      rating: rating ?? this.rating,
      productDetail: productDetail ?? this.productDetail,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        thumbnail,
        availabilityStatus,
        rating,
        productDetail,
      ];
}

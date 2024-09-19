import 'package:ecommerce_concept/features/product/domain/entities/review_entity.dart';
import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final double discountPercentage;
  final int stock;
  final String brand;
  final String category;
  final List<String> images;
  final List<ReviewEntity> reviews;

  const ProductDetailEntity({
    required this.discountPercentage,
    required this.stock,
    required this.brand,
    required this.category,
    required this.images,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
    discountPercentage,
    stock,
    brand,
    category,
    images,
    reviews,
  ];
}
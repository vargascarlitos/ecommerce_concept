import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_detail_view.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductEntity product;

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    return ProductDetailView(
      product: product,
    );
  }
}

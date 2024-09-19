import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/domain/entities/review_entity.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/shake_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  Widget _buildReviewsSection(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) {
      return const Text('No reviews yet.');
    }
    return Column(
      children: reviews.map((review) {
        return Card(
          color: AppPalette.black01,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(review.reviewerName,
                    style: const TextStyle(color: AppPalette.white)),
                Text(
                  review.date.toLocal().weekday == DateTime.now().weekday
                      ? 'Today'
                      : review.date.toLocal().weekday ==
                              DateTime.now()
                                  .subtract(const Duration(days: 1))
                                  .weekday
                          ? 'Yesterday'
                          : review.date.toLocal().toString().substring(0, 10),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBarIndicator(
                  rating: product.rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  unratedColor: Colors.grey,
                  itemCount: 5,
                  itemSize: 12.0,
                  direction: Axis.horizontal,
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppPalette.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Add to cart functionality
            },
          ),
        ],
        title: Text(
          product.title,
          style: const TextStyle(
            color: AppPalette.white,
            fontSize: 28.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: AppPalette.black01,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppPalette.black01,
                    borderRadius: BorderRadius.circular(24.0)),
                height: 300,
                child: Column(
                  children: [
                    Hero(
                      tag: 'product_${product.id}',
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail,
                        cacheKey: product.thumbnail,
                        cacheManager:
                            CachedNetworkImageProvider.defaultCacheManager,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
              ShakeTransition(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          " ${product.productDetail.category}",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: product.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          " ${product.rating} ",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: AppPalette.black01,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "(${product.productDetail.reviews.length} Reviews)",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '\$ ${product.price}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: product.availabilityStatus.contains('In')
                                ? Colors.green.withOpacity(0.8)
                                : Colors.red.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.availabilityStatus,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPalette.black01,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Reviews (${product.productDetail.reviews.length})',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPalette.black01,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    _buildReviewsSection(product.productDetail.reviews),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

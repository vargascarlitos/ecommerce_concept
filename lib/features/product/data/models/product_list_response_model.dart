import 'package:ecommerce_concept/features/product/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_response_model.g.dart';

@JsonSerializable()
class ProductListResponseModel {
  final List<ProductModel>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductListResponseModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseModelToJson(this);
}

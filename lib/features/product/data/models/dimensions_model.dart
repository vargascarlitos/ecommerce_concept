import 'package:json_annotation/json_annotation.dart';

part 'dimensions_model.g.dart';

@JsonSerializable()
class DimensionsModel {
  final double? width;
  final double? height;
  final double? depth;

  DimensionsModel({
    this.width,
    this.height,
    this.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsModelToJson(this);
}

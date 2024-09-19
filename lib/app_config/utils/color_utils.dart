import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  /// random color from AppPalette
  static Color randomColor() {
    final colors = [
      AppPalette.green,
      AppPalette.pink,
      AppPalette.purple,
      AppPalette.white,
      AppPalette.yellow,
    ];
    return Color((colors..shuffle()).first.value);
  }
}
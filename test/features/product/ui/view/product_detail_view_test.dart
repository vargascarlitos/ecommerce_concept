import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_detail_view.dart';

void main() {

  const mockProduct = TestHelper.productEntity;

  Widget createWidgetUnderTest(ProductEntity product) {
    return MaterialApp(
      home: ProductDetailView(product: product),
    );
  }


  testWidgets('renders ProductDetailView with all main sections',
          (WidgetTester tester) async {
        // Renderiza la vista del producto
        await tester.pumpWidget(createWidgetUnderTest(mockProduct));

        // Espera a que se rendericen los widgets
        await tester.pump(const Duration(seconds: 2));

        // Verifica que la descripción del producto esté presente
        expect(find.text('Mascara'), findsOneWidget);

        // Verifica que se muestren las imágenes del producto
        expect(find.byType(CachedNetworkImage), findsWidgets);

        // Verifica que se muestren las reseñas del producto
        expect(find.text('Good product'), findsOneWidget);
      });
}
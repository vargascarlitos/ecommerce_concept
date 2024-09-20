import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/ui/pages/product_detail_page.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/product_grid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class FakeRoute extends Fake implements Route<dynamic> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  // Registra la clase Fake para Route<dynamic>
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
  });


  group('ProductItemWidget', () {
    testWidgets('navigates to ProductDetailPage when tapped', (tester) async {
      // Mock product para la prueba
      const mockProduct = TestHelper.productEntity;

      // Inicia el widget bajo prueba
      // Inicia el widget bajo prueba
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockNavigatorObserver],
          onGenerateRoute: (settings) {
            if (settings.name == ProductDetailPage.routeName) {
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Text('Product Detail Page for ${settings.arguments}'),
                ),
                settings: settings,
              );
            }
            return null;
          },
          home: Scaffold(
            body: ProductItemWidget(product: mockProduct),
          ),
        ),
      );

      // Verifica que el widget ProductItemWidget está en pantalla
      expect(find.byType(ProductItemWidget), findsOneWidget);

      // Simula el toque en el widget
      await tester.tap(find.byType(ProductItemWidget));
      await tester.pumpAndSettle();

      // Verifica que se llamó a la navegación con los argumentos correctos
      verify(() => mockNavigatorObserver.didPush(any(), any())).called(2);

      // Verifica que se navega al ProductDetailPage con el producto adecuado
      expect(find.text('Product Detail Page for ${mockProduct}'), findsOneWidget);
    });
  });
}
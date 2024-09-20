import 'package:bloc_test/bloc_test.dart';

import 'package:ecommerce_concept/app_config/error/failure.dart';
import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:ecommerce_concept/features/product/ui/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_list_view.dart';
import 'package:ecommerce_concept/app_config/injector/injector.dart'
    as injector;

// Crear un Mock del ProductBloc
class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

// Extensión para inicializar la página con el Bloc
extension on WidgetTester {
  Future<void> pumpProductList(ProductBloc productBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: productBloc,
          child: const ProductListPage(),
        ),
      ),
    );
  }
}

void main() {
  final sl = GetIt.instance;

  final mockProducts = [
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
    TestHelper.productEntity,
  ];

  late ProductBloc productBloc;

  setUp(() {
    injector.reset();
    productBloc = MockProductBloc();
    injector.init();
  });

  tearDown(() {
    // Limpia GetIt después de cada prueba
    sl.reset();
  });

  group('ProductListPage', () {
    testWidgets(
        'renders ProductListView when state is success and has products',
        (tester) async {
      // Configura el mock del estado del bloc
      when(() => productBloc.state).thenReturn(
        ProductState(status: ProductStatus.success, products: mockProducts),
      );

      // Inicia el test
      await tester.pumpProductList(productBloc);
      await tester.pumpAndSettle();

      // Verifica que se renderiza ProductListView
      expect(find.byType(ProductListView), findsOneWidget);
    });

    testWidgets('shows error dialog when state is failure', (tester) async {
      // Configura el estado del bloc para failure
      when(() => productBloc.state).thenReturn(
        const ProductState(
          status: ProductStatus.failure,
          failure: ServerFailure('Failed to fetch products'),
        ),
      );

      // Inicia el test
      await tester.pumpProductList(productBloc);
      await tester.pumpAndSettle();

      // Verifica que se muestra el diálogo de error
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

  });
}

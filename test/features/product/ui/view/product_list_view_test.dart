import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_concept/app_config/utils/test_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_list_view.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/product_grid_item_widget.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/empty_widget.dart';
import 'package:ecommerce_concept/app_config/injector/injector.dart'
as injector;

class MockProductBloc extends MockBloc<ProductEvent, ProductState> implements ProductBloc {}

extension on WidgetTester {
  Future<void> pumpProductListView(ProductBloc productBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: productBloc,
          child: const ProductListView(),
        ),
      ),
    );
  }
}

void main() {
  late MockProductBloc mockProductBloc;

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

  setUp(() {
    injector.reset();
    mockProductBloc = MockProductBloc();
    injector.init();
  });

  tearDown(() {
    sl.reset();
  });

  group('ProductListView', () {
    testWidgets('renders CircularProgressIndicator when state is loading', (tester) async {
      // Configura el mock del estado del bloc para loading
      when(() => mockProductBloc.state).thenReturn(const ProductState(status: ProductStatus.loading));

      // Renderiza la vista
      await tester.pumpProductListView(mockProductBloc);
      await tester.pump(const Duration(seconds: 1)); // Usa pump con duración específica

      // Verifica que se muestra el indicador de carga
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders EmptyWidget when state is failure', (tester) async {
      // Configura el mock del estado del bloc para failure
      when(() => mockProductBloc.state).thenReturn(const ProductState(status: ProductStatus.failure));

      // Renderiza la vista
      await tester.pumpProductListView(mockProductBloc);
      await tester.pump(const Duration(seconds: 1)); // Usa pump con duración específica

      // Verifica que se muestra el widget de error
      expect(find.byType(EmptyWidget), findsOneWidget);
    });

    testWidgets('renders EmptyWidget when state is failure', (tester) async {
      // Configura el mock del estado del bloc para failure
      when(() => mockProductBloc.state).thenReturn(const ProductState(status: ProductStatus.failure));

      // Renderiza la vista
      await tester.pumpProductListView(mockProductBloc);
      await tester.pumpAndSettle();

      // Verifica que se muestra el widget de error
      expect(find.byType(EmptyWidget), findsOneWidget);
    });

    testWidgets('renders list of products when state is success', (tester) async {
      // Configura el mock del estado del bloc para success con productos
      when(() => mockProductBloc.state).thenReturn(ProductState(
        status: ProductStatus.success,
        products: mockProducts,
        hasReachedMax: false,
      ));

      // Renderiza la vista
      await tester.pumpProductListView(mockProductBloc);
      await tester.pump(const Duration(seconds: 2));

      // Verifica que se renderizan los productos en la lista
      expect(find.byType(ProductItemWidget), findsNWidgets(4));
    });

    testWidgets('renders list of products when state is success', (tester) async {
      // Configura el mock del estado del bloc para success con productos
      when(() => mockProductBloc.state).thenReturn(ProductState(
        status: ProductStatus.success,
        products: mockProducts,
        hasReachedMax: false,
      ));

      // Renderiza la vista
      await tester.pumpProductListView(mockProductBloc);
      await tester.pump(const Duration(seconds: 2));

      // Verifica que se renderizan los productos en la lista
      expect(find.byType(ProductItemWidget), findsNWidgets(4));
    });

  });
}
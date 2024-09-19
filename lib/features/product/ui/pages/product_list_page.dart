import 'package:ecommerce_concept/app_config/injector/injector.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productRepository: sl<ProductRepository>(),
      )..add(ProductFetched()),
      child: const ProductListView(),
    );
  }
}

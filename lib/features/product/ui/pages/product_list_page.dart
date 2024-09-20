import 'package:ecommerce_concept/app_config/injector/injector.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/view/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productRepository: sl<ProductRepository>(),
      )..add(ProductFetched()),
      child: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ProductStatus.failure) {
            print("Estoy aca mi rey");
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(
                    state.failure?.message.toString() ?? "Error occurred",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const ProductListView(),
      ),
    );
  }
}

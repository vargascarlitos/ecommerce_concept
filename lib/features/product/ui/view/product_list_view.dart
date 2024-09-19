import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/product_grid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.black01,
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: const _ProductList(),
    );
  }
}

class _ProductList extends StatefulWidget {
  const _ProductList({super.key});

  @override
  State<_ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state.status) {
          case ProductStatus.failure:
            return const Center(child: Text('Failed to fetch products'));
          case ProductStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('No products'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.products.length
                    ? const Center(child: CircularProgressIndicator())
                    : ProductItemWidget(
                        thumbnail: state.products[index].thumbnail,
                        title: state.products[index].title,
                        description: state.products[index].description,
                        price: state.products[index].price,
                        availableStatus: state.products[index].availabilityStatus,
                        rating: state.products[index].rating,
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.products.length
                  : state.products.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ProductBloc>().add(ProductFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}


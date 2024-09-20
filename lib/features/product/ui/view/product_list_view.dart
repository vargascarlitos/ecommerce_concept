import 'package:ecommerce_concept/app_config/style/app_palette.dart';
import 'package:ecommerce_concept/features/product/ui/bloc/product_bloc.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/empty_widget.dart';
import 'package:ecommerce_concept/features/product/ui/widgets/product_grid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppPalette.black01,
      appBar: _ProductAppBar(),
      body: _ProductList(),
    );
  }
}

class _ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProductAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Products List',
        style: TextStyle(
          color: AppPalette.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      backgroundColor: AppPalette.black01,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
            return  Center(
              child: EmptyWidget(
                onPressed: () {
                  context.read<ProductBloc>().add(ProductRefreshed());
                },
              ),
            );
          case ProductStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('No products'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(ProductRefreshed());
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.products.length
                      ? const Center(child: CircularProgressIndicator())
                      : ProductItemWidget(
                          product: state.products[index],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
                controller: _scrollController,
              ),
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

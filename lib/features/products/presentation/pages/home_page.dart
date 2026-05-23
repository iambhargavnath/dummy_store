import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/di/injection.dart';

import '../../domain/entities/product_entity.dart';

import '../bloc/product_bloc.dart';
import '../widgets/product_card_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductBloc _bloc;

  static const int _pageSize = 20;

  final TextEditingController
  _searchController =
  TextEditingController();

  final PagingController<int, ProductEntity>
  _pagingController =
  PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    super.initState();

    _bloc = sl<ProductBloc>();

    _pagingController
        .addPageRequestListener(
      _fetchPage,
    );
  }

  Future<void> _fetchPage(
      int pageKey,
      ) async {
    try {
      final isSearching =
          _searchController
              .text
              .trim()
              .isNotEmpty;

      final products = isSearching
          ? await _bloc
          .getProductsUseCase
          .repository
          .searchProducts(
        _searchController.text,
        limit: _pageSize,
        skip: pageKey,
      )
          : await _bloc
          .getProductsUseCase(
        limit: _pageSize,
        skip: pageKey,
      );

      final isLastPage =
          products.length < _pageSize;

      if (isLastPage) {
        _pagingController
            .appendLastPage(products);
      } else {
        final nextPageKey =
            pageKey + products.length;

        _pagingController.appendPage(
          products,
          nextPageKey,
        );
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();

    _pagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DummyStore',
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          _buildSearchBar(),

          Expanded(
            child: PagedListView<
                int,
                ProductEntity>(
              pagingController:
              _pagingController,

              builderDelegate:
              PagedChildBuilderDelegate<
                  ProductEntity>(
                itemBuilder: (
                    context,
                    product,
                    index,
                    ) {
                  return ProductCardItem(
                    product: product,

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments:
                        product,
                      );
                    },
                  );
                },

                firstPageProgressIndicatorBuilder:
                    (_) =>
                const Center(
                  child:
                  CircularProgressIndicator(),
                ),

                newPageProgressIndicatorBuilder:
                    (_) =>
                const Padding(
                  padding:
                  EdgeInsets.all(
                    16,
                  ),
                  child: Center(
                    child:
                    CircularProgressIndicator(),
                  ),
                ),

                noItemsFoundIndicatorBuilder:
                    (_) =>
                const Center(
                  child: Text(
                    'No products found',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),

      child: TextField(
        controller:
        _searchController,

        decoration: InputDecoration(
          hintText: 'Search products',

          prefixIcon:
          const Icon(
            Icons.search,
          ),

          filled: true,

          border:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              12,
            ),
          ),
        ),

        onChanged: (_) {
          _pagingController.refresh();
        },
      ),
    );
  }
}
part of 'product_bloc.dart';

class ProductState {
  final bool loading;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String search;

  ProductState({
    this.loading = false,
    this.products = const [],
    this.filteredProducts = const [],
    this.search = '',
  });

  ProductState copyWith({
    bool? loading,
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? search,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      search: search ?? this.search,
    );
  }
}
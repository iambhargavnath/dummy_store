import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc
    extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase
  getProductsUseCase;

  ProductBloc(this.getProductsUseCase)
      : super(ProductState()) {
    on<LoadProducts>(_loadProducts);

    on<SearchProducts>(
      _searchProducts,
    );
  }

  Future<void> _loadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    final newProducts =
    await getProductsUseCase(
      limit: 20,
      skip: event.pageKey,
    );

    emit(
      state.copyWith(
        loading: false,

        products: [
          ...state.products,
          ...newProducts,
        ],
      ),
    );
  }

  Future<void> _searchProducts(
      SearchProducts event,
      Emitter<ProductState> emit,
      ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(
          search: '',
          filteredProducts: [],
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        loading: true,
      ),
    );

    final products =
    await getProductsUseCase
        .repository
        .searchProducts(
      event.query,
    );

    emit(
      state.copyWith(
        loading: false,

        search: event.query,

        filteredProducts:
        products,
      ),
    );

  }
}
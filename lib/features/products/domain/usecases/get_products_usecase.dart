import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({
    int limit = 20,
    int skip = 0,
  }) {
    return repository.getProducts(limit: limit, skip: skip);
  }
}
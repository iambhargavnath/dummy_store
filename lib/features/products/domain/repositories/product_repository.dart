import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({
    int limit,
    int skip,
  });

  Future<List<ProductEntity>>
  searchProducts(
      String query, {
        int limit = 20,
        int skip = 0,
      });
}
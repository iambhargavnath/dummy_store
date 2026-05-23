import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final AppDatabase database;

  ProductRepositoryImpl(
      this.remote,
      this.database,
      );

  @override
  Future<List<ProductEntity>> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final remoteProducts = await remote.getProducts(
        limit: limit,
        skip: skip,
      );

      await database.insertProducts(
        remoteProducts.map((e) {
          return ProductsCompanion(
            id: Value(e.id),
            title: Value(e.title),
            description: Value(e.description),
            price: Value(e.price),
            thumbnail: Value(e.thumbnail),
            category: Value(e.category),
          );
        }).toList(),
      );

      return remoteProducts;
    } catch (_) {
      final localProducts = await database.getAllProducts();

      return localProducts.map((e) {
        return ProductEntity(
          id: e.id,
          title: e.title,
          description: e.description,
          price: e.price,
          thumbnail: e.thumbnail,
          category: e.category,
        );
      }).toList();
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(
      String query, {
        int limit = 20,
        int skip = 0,
      }
      ) async {
    try {
      final remoteProducts =
      await remote.searchProducts(query);

      return remoteProducts;
    } catch (_) {
      final localProducts =
      await database.searchProducts(
        query,
      );

      return localProducts.map((e) {
        return ProductEntity(
          id: e.id,
          title: e.title,
          description: e.description,
          price: e.price,
          thumbnail: e.thumbnail,
          category: e.category,
        );
      }).toList();
    }
  }
}
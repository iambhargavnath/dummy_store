import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase database;

  ProductLocalDataSourceImpl(this.database);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final items = products.map(
      (e) => ProductsCompanion(
        id: Value(e.id),
        title: Value(e.title),
        description: Value(e.description),
        price: Value(e.price),
        thumbnail: Value(e.thumbnail),
        category: Value(e.category),
      ),
    ).toList();

    await database.insertProducts(items);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final result = await database.getAllProducts();

    return result.map(
      (e) => ProductModel(
        id: e.id,
        title: e.title,
        description: e.description,
        price: e.price,
        thumbnail: e.thumbnail,
        category: e.category,
      ),
    ).toList();
  }
}
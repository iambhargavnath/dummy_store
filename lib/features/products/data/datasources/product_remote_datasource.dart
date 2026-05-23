import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int skip = 0,
  });

  Future<List<ProductModel>> searchProducts(
      String query, {
        int limit = 20,
        int skip = 0,
      });
}

class ProductRemoteDataSourceImpl
    implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(
      this.dio,
      );

  @override
  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    final response = await dio.get(
      '/products',
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );

    final data =
    response.data['products'] as List;

    return data
        .map(
          (e) => ProductModel.fromJson(e),
    )
        .toList();
  }

  @override
  Future<List<ProductModel>> searchProducts(
      String query, {
        int limit = 20,
        int skip = 0,
      }) async {
    final response = await dio.get(
      '/products/search',

      queryParameters: {
        'q': query,
        'limit': limit,
        'skip': skip,
      },
    );

    final data =
    response.data['products'] as List;

    return data
        .map(
          (e) => ProductModel.fromJson(e),
    )
        .toList();
  }
}
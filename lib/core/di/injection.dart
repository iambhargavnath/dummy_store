import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../database/app_database.dart';
import '../network/dio_client.dart';

import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  sl.registerLazySingleton<AppDatabase>(
        () => AppDatabase(),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GetProductsUseCase(sl()),
  );

  sl.registerFactory(
        () => ProductBloc(sl()),
  );
}
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Products extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get thumbnail => text()();
  TextColumn get category => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertProducts(
      List<ProductsCompanion> items,
      ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        products,
        items,
      );
    });
  }

  Future<List<Product>> getAllProducts() async {
    return await select(products).get();
  }

  Future<List<Product>> searchProducts(
      String query,
      ) async {
    return (select(products)
      ..where(
            (tbl) => tbl.title.like('%$query%'),
      ))
        .get();
  }

  Future<void> clearProducts() async {
    await delete(products).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir =
    await getApplicationDocumentsDirectory();

    final file = File(
      p.join(
        dir.path,
        'dummy_store.sqlite',
      ),
    );

    return NativeDatabase(file);
  });
}
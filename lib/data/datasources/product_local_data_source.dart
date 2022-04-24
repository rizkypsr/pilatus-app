import 'package:pilatusapp/data/datasources/db/database_helper.dart';
import 'package:pilatusapp/data/models/product_table.dart';

abstract class ProductLocalDataSource {
  Future<ProductTable?> getProductById(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<ProductTable?> getProductById(int id) async {
    final result = await databaseHelper.getItemById(id);
    if (result != null) {
      return ProductTable.fromMap(result);
    } else {
      return null;
    }
  }
}

import 'package:pilatusapp/data/datasources/db/database_helper.dart';
import 'package:pilatusapp/data/models/category_table.dart';

abstract class CategoryLocalDataSource {
  Future<CategoryTable?> getCategoryById(int id);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  CategoryLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<CategoryTable?> getCategoryById(int id) async {
    final result = await databaseHelper.getItemById(id);
    if (result != null) {
      return CategoryTable.fromMap(result);
    } else {
      return null;
    }
  }
}

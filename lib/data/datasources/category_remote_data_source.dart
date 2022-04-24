import 'dart:convert';

import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/category_model.dart';
import 'package:pilatusapp/data/models/category_response.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(Uri.parse('$baseApiUrl/categories'));

    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(json.decode(response.body)).categories;
    } else {
      throw ServerException();
    }
  }
}

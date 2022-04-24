import 'dart:convert';

import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/data/models/product_detail_response.dart';
import 'package:pilatusapp/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/product_response.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductDetailResponse> getProductDetail(int id);
  Future<List<ProductModel>> getProductByCategory(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse('$baseApiUrl/product'));

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductDetailResponse> getProductDetail(int id) async {
    final response = await client.get(Uri.parse('$baseApiUrl/product/$id'));
    if (response.statusCode == 200) {
      return ProductDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory(int id) async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/product/category/$id'));

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).products;
    } else {
      throw ServerException();
    }
  }
}

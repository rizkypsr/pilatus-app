import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel?> getCartList();
  Future<String> addToCart(int productId);
  Future<String> removeFromCart(int id);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  CartRemoteDataSourceImpl({required this.client, required this.secureStorage});

  @override
  Future<CartModel> getCartList() async {
    var token = await secureStorage.read(key: key);
    final response = await client.get(Uri.parse('$baseApiUrl/cart'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return CartModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addToCart(int productId) async {
    var token = await secureStorage.read(key: key);
    final body = json.encode({'product_id': productId});

    final response = await client.post(Uri.parse('$baseApiUrl/cart'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);

    if (response.statusCode == 200) {
      return 'Berhasil menambahkan produk ke keranjang';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> removeFromCart(int id) async {
    var token = await secureStorage.read(key: key);

    final response = await client.delete(
      Uri.parse('$baseApiUrl/cart/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return 'Berhasil menghapus produk dari keranjang';
    } else {
      throw ServerException();
    }
  }
}

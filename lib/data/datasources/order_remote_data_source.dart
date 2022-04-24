import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/order_detail_model.dart';
import 'package:pilatusapp/data/models/order_detail_response.dart';
import 'package:pilatusapp/data/models/order_model.dart';
import 'package:pilatusapp/data/models/order_response.dart';
import 'package:pilatusapp/data/models/payment_model.dart';
import 'package:pilatusapp/data/models/payment_response.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(String status);
  Future<OrderDetailModel> getOrderDetail(int id);
  Future<int> addOrder(Map<String, dynamic> order);
  Future<String> updatePayment(File image, int id);
  Future<String> finishOrder(int id);
  Future<PaymentModel?> getPayment(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  OrderRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<List<OrderModel>> getOrders(String status) async {
    var token = await secureStorage.read(key: key);

    final response =
        await client.get(Uri.parse('$baseApiUrl/orders/$status'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return OrderResponse.fromJson(json.decode(response.body)).orders;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderDetailModel> getOrderDetail(int id) async {
    var token = await secureStorage.read(key: key);

    final response =
        await client.get(Uri.parse('$baseApiUrl/order/$id'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return OrderDetailResponse.fromJson(json.decode(response.body)).order;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> addOrder(Map<String, dynamic> order) async {
    var token = await secureStorage.read(key: key);

    final body = json.encode({
      "products": List.from(order['products'].map(
          (x) => {"product_id": x['product_id'], "quantity": x['quantity']})),
      "total": order['total'],
      "address_id": "",
      "courier": "",
      "shipping_cost": "",
      "service": ""
    });

    final response = await client.post(Uri.parse('$baseApiUrl/order'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);

    final result = json.decode(response.body);

    if (response.statusCode == 200) {
      return result["data"];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updatePayment(File image, int id) async {
    var token = await secureStorage.read(key: key);

    final request = http.MultipartRequest(
        'POST', Uri.parse('$baseApiUrl/order/$id?_method=PUT'));
    request.headers["Authorization"] = 'Bearer $token';
    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));
    final streamRes = await request.send();
    final response = await http.Response.fromStream(streamRes);

    if (response.statusCode == 200) {
      return "Berhasil Mengirim Bukti Pembayaran";
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PaymentModel?> getPayment(int id) async {
    var token = await secureStorage.read(key: key);

    final response =
        await client.get(Uri.parse('$baseApiUrl/payment/$id'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return PaymentResponse.fromJson(json.decode(response.body)).payment;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> finishOrder(int id) async {
    var token = await secureStorage.read(key: key);

    final response =
        await client.post(Uri.parse('$baseApiUrl/order/status/$id'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return "Berhasil Menyelesaikan Order";
    } else {
      throw ServerException();
    }
  }
}

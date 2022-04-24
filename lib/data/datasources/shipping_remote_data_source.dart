import 'dart:convert';

import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/costs_model.dart';
import 'package:pilatusapp/data/models/costs_response.dart';

abstract class ShippingRemoteDataSource {
  Future<List<CostsModel>> getCost(int origin, int destination, int weight);
}

class ShippingRemoteDataSourceImpl implements ShippingRemoteDataSource {
  final http.Client client;

  ShippingRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CostsModel>> getCost(
      int origin, int destination, int weight) async {
    final body = json.encode({
      'origin': origin,
      'destination': destination,
      'weight': weight,
      'courier': 'jne'
    });

    final response = await client.post(Uri.parse('$rajaOngkirUrl/cost'),
        headers: {
          "Content-Type": "application/json",
          'key': rajaOngkirKey,
        },
        body: body);

    if (response.statusCode == 200) {
      return CostsResponse.fromJson(json.decode(response.body)).costs;
    } else {
      throw ServerException();
    }
  }
}

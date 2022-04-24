import 'dart:convert';

import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/bank_model.dart';
import 'package:pilatusapp/data/models/bank_response.dart';

abstract class BankRemoteDataSource {
  Future<BankModel> getBank();
}

class BankRemoteDataSourceImpl implements BankRemoteDataSource {
  final http.Client client;

  BankRemoteDataSourceImpl({required this.client});

  @override
  Future<BankModel> getBank() async {
    final response = await client.get(Uri.parse('$baseApiUrl/bank'));

    if (response.statusCode == 200) {
      return BankResponse.fromJson(json.decode(response.body)).bank;
    } else {
      throw ServerException();
    }
  }
}

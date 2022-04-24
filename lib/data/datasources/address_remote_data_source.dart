import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/address_model.dart';
import 'package:pilatusapp/data/models/address_response.dart';
import 'package:pilatusapp/data/models/city_model.dart';
import 'package:pilatusapp/data/models/city_response.dart';
import 'package:pilatusapp/data/models/province_model.dart';
import 'package:pilatusapp/data/models/province_response.dart';
import 'package:pilatusapp/domain/entities/address.dart';

abstract class AddressRemoteDataSource {
  Future<List<ProvinceModel>> getProvince();
  Future<List<CityModel>> getCities(int provinceId);
  Future<AddressModel> getAddress();
  Future<String> saveAddress(Address address);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  AddressRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<List<CityModel>> getCities(int provinceId) async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/city/$provinceId'));

    if (response.statusCode == 200) {
      return CityResponse.fromJson(json.decode(response.body)).cities;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProvinceModel>> getProvince() async {
    final response = await client.get(Uri.parse('$baseApiUrl/province'));

    if (response.statusCode == 200) {
      return ProvinceResponse.fromJson(json.decode(response.body)).province;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> saveAddress(Address address) async {
    var token = await secureStorage.read(key: key);

    final body = json.encode({
      'street': address.street,
      'province_id': address.province.provinceId,
      'city_id': address.city.cityId,
      'postal_code': address.postalCode,
      'district': address.district,
    });

    final response = await client.post(Uri.parse('$baseApiUrl/address'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);

    if (response.statusCode == 200) {
      return 'Berhasil menyimpan alamat';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddressModel> getAddress() async {
    var token = await secureStorage.read(key: key);
    final response = await client.get(
      Uri.parse('$baseApiUrl/address'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return AddressResponse.fromJson(json.decode(response.body)).address;
    } else {
      throw ServerException();
    }
  }
}

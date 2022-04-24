import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/user_model.dart';
import 'package:pilatusapp/data/models/user_response.dart';
import 'package:pilatusapp/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<String> updateUser(User user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  UserRemoteDataSourceImpl({required this.client, required this.secureStorage});

  @override
  Future<String> updateUser(User user) async {
    final body = json.encode({"email": user.email, "name": user.name});
    final token = await secureStorage.read(key: key);

    final response = await client.post(Uri.parse('$baseApiUrl/user/update'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: body);

    if (response.statusCode == 200) {
      return "Berhasil Memperbaharui Profil";
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser() async {
    final token = await secureStorage.read(key: key);

    final response = await client.get(Uri.parse('$baseApiUrl/user'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body)).user;
    } else {
      throw ServerException();
    }
  }
}

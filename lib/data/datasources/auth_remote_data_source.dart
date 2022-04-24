import 'dart:convert';

import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/data/models/auth_model.dart';
import 'package:pilatusapp/data/models/auth_response.dart';
import 'package:pilatusapp/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(User user);
  Future<AuthModel> register(Map<String, String> data);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthModel> login(User user) async {
    final body = json.encode({"email": user.email, "password": user.password});

    final response = await client.post(Uri.parse('$baseApiUrl/login'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body)).auth;
    } else if (response.statusCode == 500) {
      throw AuthenticationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> register(Map<String, String> data) async {
    final body = json.encode(data);

    final response = await client.post(Uri.parse('$baseApiUrl/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    print(response.body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body)).auth;
    } else if (response.statusCode == 403) {
      throw AuthenticationException();
    } else {
      throw ServerException();
    }
  }
}

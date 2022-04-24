import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatusapp/common/constants.dart';

abstract class AuthLocalDataSource {
  Future<String> saveToken(String token);
  Future<String> removeToken();
  Future<String?> getToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<String> saveToken(String token) async {
    await secureStorage.write(key: key, value: token);
    return "Token saved";
  }

  @override
  Future<String?> getToken() async {
    final token = await secureStorage.read(key: key);
    return token;
  }

  @override
  Future<String> removeToken() async {
    await secureStorage.delete(key: key);
    return "Token deleted";
  }
}

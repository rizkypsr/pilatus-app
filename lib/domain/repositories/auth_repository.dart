import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/auth.dart';
import 'package:pilatusapp/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> register(Map<String, String> data);
  Future<Either<Failure, Auth>> login(User user);
  Future<Either<Failure, String>> saveToken(String token);
  Future<String?> getToken();
  Future<Either<Failure, String>> logout();
}

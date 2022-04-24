import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/auth.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class RegisterAuth {
  final AuthRepository repository;

  RegisterAuth(this.repository);

  Future<Either<Failure, Auth>> execute(Map<String, String> data) {
    return repository.register(data);
  }
}

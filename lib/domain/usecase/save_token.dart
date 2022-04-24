import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class SaveToken {
  final AuthRepository repository;

  SaveToken(this.repository);

  Future<Either<Failure, String>> execute(String token) {
    return repository.saveToken(token);
  }
}

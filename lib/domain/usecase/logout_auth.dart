import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class LogoutAuth {
  final AuthRepository repository;

  LogoutAuth(this.repository);

  Future<Either<Failure, String>> execute() {
    return repository.logout();
  }
}

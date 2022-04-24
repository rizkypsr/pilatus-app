import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/auth.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class LoginAuth {
  final AuthRepository repository;

  LoginAuth(this.repository);

  Future<Either<Failure, Auth>> execute(User user) {
    return repository.login(user);
  }
}

import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class GetToken {
  final AuthRepository repository;

  GetToken(this.repository);

  Future<String?> execute() {
    return repository.getToken();
  }
}

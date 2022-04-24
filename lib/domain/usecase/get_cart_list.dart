import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/cart.dart';
import 'package:pilatusapp/domain/repositories/cart_repository.dart';

class GetCartList {
  final CartRepository repository;

  GetCartList(this.repository);

  Future<Either<Failure, Cart?>> execute() {
    return repository.getCartList();
  }
}

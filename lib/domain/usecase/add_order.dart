import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class AddOrder {
  final OrderRepository repository;

  AddOrder(this.repository);

  Future<Either<Failure, int>> execute(Map<String, dynamic> order) {
    return repository.addOrder(order);
  }
}

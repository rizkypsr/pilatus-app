import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/payment.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class GetPayment {
  final OrderRepository repository;

  GetPayment(this.repository);

  Future<Either<Failure, Payment?>> execute(int id) {
    return repository.getPayment(id);
  }
}

import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class GetOrderDetail {
  final OrderRepository repository;

  GetOrderDetail(this.repository);

  Future<Either<Failure, OrderDetail>> execute(int id) {
    return repository.getOrderDetail(id);
  }
}

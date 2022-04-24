import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class FinishOrder {
  final OrderRepository repository;

  FinishOrder(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.finishOrder(id);
  }
}
